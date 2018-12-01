import React, { Component } from 'react';
import AppBar from './layout/AppBar'
import 'antd/dist/antd.css';
import { Route, withRouter } from 'react-router-dom'
import Configure from './Configure'
import requiredCookies from './tools/requiredCookies'
import { withCookies } from 'react-cookie'
import getNeo4j from './tools/neo4j'
import Molecules from './molecules/Molecules'
import { message } from 'antd';
import {mapStateToProps, mapDispatchToProps} from './redux/tools'
import {connect} from 'react-redux'

const About = (props) => {
  return (
    <div>
      About
    </div>
  )
}

class App extends Component {

  componentWillUnmount() {
    if (this.props.neo.driver)
        this.props.neo.driver.close()
  }

  componentDidMount() {
    const {cookies} = this.props
    try {
      const neo = getNeo4j(cookies.get('endpoint'), cookies.get('username'), cookies.get('password'))
      message.success('connected to the neo4j db')
      this.props.updateNeo(neo.session, neo.driver)
    }
    catch (e) {
      console.log('fail to connect neo4j', e)
      message.error('failed to connect to the neo4j db')
      this.props.history.push('/configure')
    }
  }

  render() {
    const privateRoute = [
      <Route path="/molecules" key={0} component={Molecules} />
    ]
    const publicRoute = [
      <Route path="/configure" key={1} component={Configure} />,
      <Route path="/about" key={2} component={About} />
    ]
    console.log(this.props.neo)
    return (
      <div >
        <AppBar />
        {this.props.neo.session && privateRoute}
        {publicRoute}
      </div>
    );
  }
}

export default (withRouter(withCookies(connect(mapStateToProps, mapDispatchToProps)(App))));
