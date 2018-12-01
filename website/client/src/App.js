import React, { Component } from 'react';
import AppBar from './layout/AppBar'
import 'antd/dist/antd.css';
import { Route, withRouter } from 'react-router-dom'
import Configure from './Configure'
import requiredCookies from './tools/requiredCookies'
import { withCookies } from 'react-cookie'


const About = (props) => {
  return (
    <div>
      About
    </div>
  )
}

class App extends Component {
  render() {
    const { cookies } = this.props;
    if (requiredCookies.some(c => !cookies.get(c.name)) && this.props.location.pathname !== '/configure') {
      this.props.history.push('/configure')
    }

    return (
        <div >
          <AppBar />
          <Route path="/configure" component={Configure}/>
          <Route path="/about" component={About} />
          <Route path="/about" component={About} />
        </div>
    );
  }
}

export default withRouter(withCookies(App));
