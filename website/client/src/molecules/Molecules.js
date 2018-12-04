import React, { Component } from 'react';
import { connect } from 'react-redux'
import { mapStateToProps } from '../redux/tools'
import { query } from '../tools/api'
import { message, List, Card } from 'antd'
import { Row, Col } from 'antd';
import { Link } from 'react-router-dom'

const defaultQuery = 'MATCH (m:molecule) RETURN collect(m.name)'

const advencedQuery = "MATCH (m:molecule)<-[r:has]-(x) \
OPTIONAL MATCH (e:effect)<-[:haseffect]-(m) \
WITH DISTINCT m, [x.name, r.L] as sp, e \
WITH DISTINCT m, collect(sp) as species, collect(e.name) as effects \
RETURN [m.name,species,effects]"

class Molecules extends Component {

    constructor(props) {
        super(props)
        this.state = {
            data: [],
            loading: true
        }
        this.selectedQuery = advencedQuery
    }

    refresh = async () => {
        try {
            let data = await query(this.selectedQuery, this.props)
            const finalData = data.map(mol => {
                mol = mol._fields[0]
                let species = []
                for (let i in mol[1]) { // iterate over all species
                    const spe = mol[1][i] //name proba
                    const effect = mol[2][i]
                    species.push({
                        name: spe[0],
                        proba: spe[1],
                        effect
                    })
                }
                return ({
                    name: mol[0],
                    species
                })
            })
            this.setState({ data: finalData })
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
            <div >
                <h1 style={{ width: '100%', textAlign: 'center' }}>
                    Molecules
                </h1>
                <Row type="flex" justify="space-around" align="top">
                    {this.state.data.map(molecule => {
                        console.log(molecule)
                        return (
                            <Col sm={24} md={12} lg={8} xl={6} style={{ padding: '20px' }}>
                                <Card
                                    extra={<Link to="/map">map</Link>}
                                    title={
                                        <span className="first-cap first-cap-span" style={{ color: "#2D397F" }}>
                                            {molecule.name}
                                        </span>
                                    }
                                >
                                    {molecule.species.map(spe => {
                                        return (
                                            <div style={{ textAlign: 'left' }}>
                                                <span style={{ color: "#33964d" }}>
                                                    {spe.name}:
                                                </span>
                                                <div style={{ paddingLeft: '50px' }}>
                                                    probability: {spe.proba}<br />
                                                    {spe.effect && `effect: ${spe.effect}`}
                                                </div>
                                            </div>
                                        )
                                    })}
                                </Card>
                            </Col>
                        )
                    })}
                </Row>
            </div>
        );
    }
}

//<List
//                    style={{margin: 'auto', maxWidth: '600px', textAlign: 'left'}}
//                    loading={this.state.loading}
//                    itemLayout="horizontal"
//                    dataSource={this.state.data}
//                    renderItem={item => {
//                        return (
//                        <List.Item>
//                            {item}
//                        </List.Item>
//                        )
//                    }}
//                />

export default connect(mapStateToProps)(Molecules);
