import React, { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import api from '../api';
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';

function Tracking() {
    const [telemetry, setTelemetry] = useState([]);

    useEffect(() => {
        api.get('telemetry/').then(res => setTelemetry(res.data)).catch(console.error);
        const interval = setInterval(() => {
            api.get('telemetry/').then(res => setTelemetry(res.data)).catch(console.error);
        }, 5000);
        return () => clearInterval(interval);
    }, []);

    return (
        <Layout>
            <div className="content-card" style={{ height: '80vh', display: 'flex', flexDirection: 'column' }}>
                <h3>Global Fleet Tracker</h3>
                <div style={{ flex: 1, width: '100%', borderRadius: '8px', overflow: 'hidden' }}>
                    <MapContainer center={[13.0827, 80.2707]} zoom={11} style={{ height: '100%', width: '100%' }}>
                        <TileLayer
                            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                            attribution="&copy; OpenStreetMap contributors"
                        />
                        {telemetry.slice(-15).map((t, index) => (
                            <Marker key={index} position={[t.latitude, t.longitude]}>
                                <Popup>
                                    <b>Vehicle: {t.vehicle}</b><br/>
                                    Speed: {t.speed} km/h<br/>
                                    Fuel: {t.fuel_level}%
                                </Popup>
                            </Marker>
                        ))}
                    </MapContainer>
                </div>
            </div>
        </Layout>
    );
}
export default Tracking;
