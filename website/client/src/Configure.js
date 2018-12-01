import React, { Component } from 'react';
import requiredCookies from './tools/requiredCookies'
import { withCookies } from 'react-cookie'
import { Input, Button } from 'antd'

class Configure extends Component {

    constructor(props) {
        super(props)
        this.state = {
            changed: {}
        }
    }

    update = (e) => {
        const { changed } = this.state
        changed[e.target.name] = [e.target.value]
        this.setState({ changed: changed })
    }

    onConfirm = () => {
        const { cookies } = this.props
        const { changed } = this.state
        for (let key in changed) {
            console.log(key, changed[key])
            cookies.set(key, changed[key], { path: '/' });
        }
    }

    render() {
        return (
            <div style={{width: '100%', textAlign: "center"}}>
                {requiredCookies.map(c => {
                    return (
                        <div key={c.name} style={{margin: '30px'}}>
                            <Input type={c.name === "password" ? "password" : "text"} name={c.name} style={{ maxWidth: "300px"}} placeholder={c.name} key={c.name} onChange={this.update} />
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

export default withCookies(Configure);
