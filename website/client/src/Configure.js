import React, { Component } from 'react';
import requiredCookies from './tools/requiredCookies'
import { withCookies } from 'react-cookie'
import { Input, Button, message } from 'antd'
import {mapDispatchToProps} from './redux/tools'
import {connect} from 'react-redux'
import getNeo4j from './tools/neo4j'

class Configure extends Component {

    constructor(props) {
        super(props)
        this.state = {
            changed: {}
        }
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
            cookies.set(key, changed[key], { path: '/' });
        }
        try {
            const neo = getNeo4j(cookies.get('endpoint'), cookies.get('username'), cookies.get('password'))
            message.success('connected to the neo4j db')
            this.props.updateNeo(neo.session, neo.driver)
        }
        catch (e) {
          console.log('fail to connect neo4j', e)
          message.error('failed to connect to the neo4j db')
        }
    }

    render() {
        return (
            <div style={{width: '100%', textAlign: "center"}}>
                {requiredCookies.map(c => {
                    return (
                        <div key={c.name} style={{margin: '30px'}}>
                            <Input type={c.name === "password" ? "password" : "text"} name={c.name}
                            style={{ maxWidth: "300px"}}
                            placeholder={c.name}
                            key={c.name}
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
