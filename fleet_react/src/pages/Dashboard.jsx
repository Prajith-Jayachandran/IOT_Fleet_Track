import React, { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import api from '../api';
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';
import { Line } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend } from 'chart.js';

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend);

// Fix leaflet marker icon issue in react
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
    iconRetinaUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png',
    iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
    shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
});

function Dashboard() {
    const [vehicles, setVehicles] = useState([]);
    const [telemetry, setTelemetry] = useState([]);

    useEffect(() => {
        api.get('vehicles/').then(res => setVehicles(res.data)).catch(console.error);
        api.get('telemetry/').then(res => setTelemetry(res.data)).catch(console.error);
        
        // Poll for live telemetry every 5s
        const interval = setInterval(() => {
            api.get('telemetry/').then(res => setTelemetry(res.data)).catch(console.error);
        }, 5000);
        return () => clearInterval(interval);
    }, []);

    const activeCount = vehicles.filter(v => v.status === 'ACTIVE').length;
    
    // Prepare chart data
    const chartData = {
        labels: telemetry.slice(-10).map(t => new Date(t.timestamp).toLocaleTimeString()),
        datasets: [
            {
                label: 'Fleet Average Speed (km/h)',
                data: telemetry.slice(-10).map(t => t.speed),
                borderColor: '#10b981',
                backgroundColor: 'rgba(16, 185, 129, 0.2)',
                tension: 0.4
            }
        ]
    };

    return (
        <Layout>
            <div className="kpi-grid">
                <div className="kpi-card">
                    <span className="kpi-value">{vehicles.length}</span>
                    <span className="kpi-label">Total Fleet</span>
                </div>
                <div className="kpi-card">
                    <span className="kpi-value" style={{color: 'var(--status-active)'}}>{activeCount}</span>
                    <span className="kpi-label">Active Vehicles</span>
                </div>
                <div className="kpi-card">
                    <span className="kpi-value" style={{color: 'var(--accent-blue)'}}>{telemetry.length}</span>
                    <span className="kpi-label">Data Points Logged</span>
                </div>
            </div>

            <div className="content-card">
                <h3>Live Map Tracking</h3>
                <div className="map-container">
                    <MapContainer center={[13.0827, 80.2707]} zoom={11} style={{ height: '100%', width: '100%' }}>
                        <TileLayer
                            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                            attribution='&copy; OpenStreetMap contributors'
                        />
                        {/* Get latest telemetry per vehicle to plot */}
                        {telemetry.slice(-15).map((t, index) => (
                            <Marker key={index} position={[t.latitude, t.longitude]}>
                                <Popup>Vehicle ID: {t.vehicle}<br/>Speed: {t.speed} km/h</Popup>
                            </Marker>
                        ))}
                    </MapContainer>
                </div>
            </div>

            <div className="content-card">
                <h3>Speed Analytics</h3>
                <div style={{ height: '300px' }}>
                    <Line data={chartData} options={{ maintainAspectRatio: false }} />
                </div>
            </div>
        </Layout>
    );
}
export default Dashboard;
