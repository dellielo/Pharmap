import React, { Component } from 'react';
import { connect } from 'react-redux'
import { mapStateToProps } from '../redux/tools'
import { query } from '../tools/api'
import { message, List } from 'antd'

const defaultQuery = 'MATCH (m:molecule) RETURN collect(m.name)'

class Molecules extends Component {

    constructor(props) {
        super(props)
        this.state = {
            data: [],
            loading: true
        }
    }

    refresh = async () => {
        console.log(defaultQuery)
        try {
            const data = await query(defaultQuery, this.props)
            this.setState({ data: data[0]._fields[0], loading: false })
            console.log(data)
        } catch (e) {
            message.error('Failed to get the data')
            this.setState({ loading: false })
            console.error(e)
        }
    }

    dumpClick = async () => {
    }

    componentDidMount() {
        this.refresh()
    }

    render() {
        console.log('data: ', this.state.data)
        return (
            <div style={{ textAlign: 'center' }}>
                <h1 style={{width: '100%'}}>
                    Molecules
                </h1>
                <div style={{width: '100%', padding: '0 50px'}}>
                <List
                    style={{margin: 'auto', maxWidth: '600px', textAlign: 'left'}}
                    loading={this.state.loading}
                    itemLayout="horizontal"
                    dataSource={this.state.data}
                    renderItem={item => {
                        return (
                        <List.Item>
                            {item}
                        </List.Item>
                        )
                    }}
                />
                </div>
            </div>
        );
    }
}

export default connect(mapStateToProps)(Molecules);
