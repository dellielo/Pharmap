import React, { Component } from 'react';
import { connect } from 'react-redux'
import { mapStateToProps } from '../redux/tools'
import { Map, TileLayer, Marker, Popup } from 'react-leaflet'
import '../../node_modules/leaflet/dist/leaflet.css'

const position = [21.289373, -157.917480]


class MapComponent extends Component {

    refresh = async () => {
    }

    componentDidMount() {
        this.refresh()
    }

    render() {
        return (
            <div id="mapid" >
                <Map center={position} zoom={13}>
                    <TileLayer
                        attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                        url='http://{s}.tile.osm.org/{z}/{x}/{y}.png'
                        zIndex={1}
                    />
                    {/* <TileLayer
                        opacity={0.5}
                        zIndex={2}
                        url=""
                    /> */}
                    <Marker position={position}>
                        <Popup>
                            A pretty CSS3 popup. <br /> Easily customizable.
                        </Popup>
                    </Marker>
                </Map>
            </div>

        );
    }
}

export default connect(mapStateToProps)(MapComponent);
