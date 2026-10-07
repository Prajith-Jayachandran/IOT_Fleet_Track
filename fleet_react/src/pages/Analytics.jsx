import React, { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import api from '../api';
import { Bar, Doughnut } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, ArcElement, Title, Tooltip, Legend } from 'chart.js';

ChartJS.register(CategoryScale, LinearScale, BarElement, ArcElement, Title, Tooltip, Legend);

function Analytics() {
    const [vehicles, setVehicles] = useState([]);
    const [telemetry, setTelemetry] = useState([]);

    useEffect(() => {
        api.get('vehicles/').then(res => setVehicles(res.data)).catch(console.error);
        api.get('telemetry/').then(res => setTelemetry(res.data)).catch(console.error);
    }, []);

    const activeCount = vehicles.filter(v => v.status === 'ACTIVE').length;
    const inactiveCount = vehicles.length - activeCount;

    const statusData = {
        labels: ['Active', 'Inactive'],
        datasets: [{
            data: [activeCount, inactiveCount],
            backgroundColor: ['#10b981', '#ef4444'],
            borderWidth: 0,
        }]
    };

    const fuelData = {
        labels: telemetry.slice(-10).map(t => 'Veh ' + t.vehicle),
        datasets: [{
            label: 'Fuel Level (%)',
            data: telemetry.slice(-10).map(t => t.fuel_level),
            backgroundColor: '#3b82f6',
        }]
    };

    return (
        <Layout>
            <div className="content-card">
                <h3>Fleet Analytics Engine</h3>
                <div style={{ display: 'flex', gap: '20px', flexWrap: 'wrap' }}>
                    
                    <div style={{ flex: '1', minWidth: '300px', background: 'rgba(0,0,0,0.2)', padding: '20px', borderRadius: '8px' }}>
                        <h4 style={{ textAlign: 'center' }}>Operational Status</h4>
                        <div style={{ height: '250px' }}>
                            <Doughnut data={statusData} options={{ maintainAspectRatio: false }} />
                        </div>
                    </div>

                    <div style={{ flex: '2', minWidth: '400px', background: 'rgba(0,0,0,0.2)', padding: '20px', borderRadius: '8px' }}>
                        <h4 style={{ textAlign: 'center' }}>Real-Time Fuel Consumption</h4>
                        <div style={{ height: '250px' }}>
                            <Bar data={fuelData} options={{ maintainAspectRatio: false }} />
                        </div>
                    </div>

                </div>
            </div>
        </Layout>
    );
}
export default Analytics;
