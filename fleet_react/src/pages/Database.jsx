import React, { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import api from '../api';

function Database() {
    const [counts, setCounts] = useState({ vehicles: 0, drivers: 0, trips: 0, telemetry: 0 });

    useEffect(() => {
        Promise.all([
            api.get('vehicles/'),
            api.get('drivers/'),
            api.get('trips/'),
            api.get('telemetry/')
        ]).then(([vRes, dRes, tRes, telRes]) => {
            setCounts({
                vehicles: vRes.data.length,
                drivers: dRes.data.length,
                trips: tRes.data.length,
                telemetry: telRes.data.length
            });
        }).catch(console.error);
    }, []);

    return (
        <Layout>
            <div className="content-card">
                <h3>DBMS Case Study: Relational Schema</h3>
                <p>This project demonstrates 3rd Normal Form (3NF) Database Normalization using Django ORM mapping to MariaDB.</p>
                
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '15px', marginTop: '20px' }}>
                    <div style={{ padding: '15px', background: 'rgba(59, 130, 246, 0.1)', border: '1px solid #3b82f6', borderRadius: '8px' }}>
                        <h4 style={{ margin: '0 0 10px 0', color: '#3b82f6' }}>Vehicles Table</h4>
                        <div style={{ fontSize: '24px', fontWeight: 'bold' }}>{counts.vehicles} Rows</div>
                    </div>
                    <div style={{ padding: '15px', background: 'rgba(16, 185, 129, 0.1)', border: '1px solid #10b981', borderRadius: '8px' }}>
                        <h4 style={{ margin: '0 0 10px 0', color: '#10b981' }}>Drivers Table</h4>
                        <div style={{ fontSize: '24px', fontWeight: 'bold' }}>{counts.drivers} Rows</div>
                    </div>
                    <div style={{ padding: '15px', background: 'rgba(245, 158, 11, 0.1)', border: '1px solid #f59e0b', borderRadius: '8px' }}>
                        <h4 style={{ margin: '0 0 10px 0', color: '#f59e0b' }}>Trips (1:N) Table</h4>
                        <div style={{ fontSize: '24px', fontWeight: 'bold' }}>{counts.trips} Rows</div>
                    </div>
                    <div style={{ padding: '15px', background: 'rgba(99, 102, 241, 0.1)', border: '1px solid #6366f1', borderRadius: '8px' }}>
                        <h4 style={{ margin: '0 0 10px 0', color: '#6366f1' }}>Telemetry Data</h4>
                        <div style={{ fontSize: '24px', fontWeight: 'bold' }}>{counts.telemetry} Rows</div>
                    </div>
                </div>

                <h4 style={{ marginTop: '30px' }}>Active Relational Foreign Keys:</h4>
                <ul style={{ color: '#9ca3af', lineHeight: '1.8' }}>
                    <li><code style={{ background: '#1e293b', padding: '2px 6px', borderRadius: '4px' }}>Trips.vehicle_id</code> references <code style={{ background: '#1e293b', padding: '2px 6px', borderRadius: '4px' }}>Vehicles.id</code></li>
                    <li><code style={{ background: '#1e293b', padding: '2px 6px', borderRadius: '4px' }}>Trips.driver_id</code> references <code style={{ background: '#1e293b', padding: '2px 6px', borderRadius: '4px' }}>Drivers.id</code></li>
                    <li><code style={{ background: '#1e293b', padding: '2px 6px', borderRadius: '4px' }}>Telemetry.vehicle_id</code> references <code style={{ background: '#1e293b', padding: '2px 6px', borderRadius: '4px' }}>Vehicles.id</code></li>
                </ul>
            </div>
        </Layout>
    );
}
export default Database;
