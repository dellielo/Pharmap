import React from 'react';
import { Menu } from 'antd';
import { Link, withRouter } from 'react-router-dom'
import './AppBar.css'
import MenuItem from 'antd/lib/menu/MenuItem';

const links = [
    { name: "Molécules", url: "/molecules" },
    { name: "Map", url: "/map" },
    { name: "Configure", url: "/configure" }
]

class AppBar extends React.Component {

    constructor(props) {
        super(props)
        this.state = {
            current: null
        }
    }

    handleClick = (e) => {
        //this.setState({
        //    current: e.key,
        //});
    }

    render() {
        return (
            <Menu
                onClick={this.handleClick}
                mode="horizontal"
                selectedKeys={[this.state.current]}
                className="menu"
            >
                <MenuItem>
                    <img className="icon" src='/logo.png' />
                    <span className="title">
                        Pharmap
            </span>
                </MenuItem>
                {links.map(l => {
                    return (
                        <Menu.Item key={l.name}>
                            <Link to={l.url}>
                                {l.name}
                            </Link>
                        </Menu.Item>
                    )
                })}
            </Menu>
        );
    }
}

export default withRouter(AppBar);
