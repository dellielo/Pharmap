import React, { Component } from 'react';
import AppBar from './layout/AppBar'
import 'antd/dist/antd.css';
import { Route, withRouter, Switch } from 'react-router-dom'
import Configure from './Configure'
import { withCookies, Cookies } from 'react-cookie'
import Molecules from './molecules/Molecules'
import { mapStateToProps, mapDispatchToProps } from './redux/tools'
import { connect } from 'react-redux'
import loaded from './tools/loaded'
import Error404 from './Error404'
import './App.css'

const About = (props) => {
  return (
    <div>
      About
    </div>
  )
}

class App extends Component {

  componentDidMount() {
    const { cookies } = this.props
    const info = ["password", "username", "endpoint"]
    let knownInfo = {}
    info.forEach(e => knownInfo[e] = cookies.get(e))
    this.props.updateInfo(knownInfo)
  }

  render() {
    const routes = [
      { component: Molecules, url: '/molecules', needLoaded: true },
      { component: Configure, url: '/configure', needLoaded: false },
      { component: About, url: '/about', needLoaded: false },
    ]
    const load = loaded(this.props)
    return (
      <div >
        <AppBar />
        <Switch>
          {routes.map(e => {
            if (!load && e.needLoaded) return "";
            return <Route path={e.url} key={e.url} component={e.component} />
          })}
          <Route path={'*'} component={Error404} />
        </Switch>
      </div>
    );
  }
}

export default (withRouter(withCookies(connect(mapStateToProps, mapDispatchToProps)(App))));
