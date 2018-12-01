import React, { Component } from 'react';
import {connect} from 'react-redux'
import {mapStateToProps} from '../redux/tools'

const defaultQuery = 'MATCH (m:molecule) RETURN collect(m.name)'

class Molecules extends Component {

    constructor(props) {
        super(props)
        this.state = {
            data: null
        }
    }

    refresh = () => {
        console.log("hey: ", defaultQuery)
        this.props.neo.session.run(defaultQuery)
        .then(r => console.log(r))
        .catch(e => console.error(e))

    }

    componentDidMount() {
        this.refresh()
    }

    render() {
        return (
            <div>
                molecules
            </div>
        );
    }
}

export default connect(mapStateToProps)(Molecules);
