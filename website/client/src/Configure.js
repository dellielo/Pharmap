import React, { Component } from 'react';
import { withCookies } from 'react-cookie'
import { Input, Button, message } from 'antd'
import {mapDispatchToProps} from './redux/tools'
import {connect} from 'react-redux'

const fields = ['endpoint', 'username',  'password']

class Configure extends Component {

    constructor(props) {
        super(props)
        const {cookies} = props
        this.state = {
            changed: fields.reduce((d, f) => {
                d[f] = cookies.get(f) || ""
                return d
            }, {})
        }
        console.log(this.state.changed)
    }

    update = (e) => {
        const { changed } = this.state
        changed[e.target.name] = e.target.value
        this.setState({ changed: changed })
    }

    onConfirm = () => {
        const { cookies } = this.props
        const { changed } = this.state
        for (let key in changed) {
            if (key === "password") continue;
            cookies.set(key, changed[key], { path: '/' });
        }
        this.props.updateInfo(changed)
        message.success('info updatated')
    }

    render() {

        return (
            <div style={{width: '100%', textAlign: "center"}}>
                {fields.map(f => {
                    return (
                        <div key={f} style={{margin: '30px'}}>
                            <Input type={f === "password" ? "password" : "text"} name={f}
                            style={{ maxWidth: "300px"}}
                            placeholder={f}
                            value={console.log(this.state.changed[f]) || this.state.changed[f]}
                            key={f}
                            onChange={this.update} />
                        </div>
                    )
                })}
                <Button onClick={this.onConfirm}>
                    Valider
                </Button>
            </div>
        );
    }
}

export default connect(null, mapDispatchToProps)(withCookies(Configure));
