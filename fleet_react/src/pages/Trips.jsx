import React, { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import api from '../api';

function Trips() {
    const [trips, setTrips] = useState([]);

    useEffect(() => {
        api.get('trips/').then(res => setTrips(res.data)).catch(console.error);
    }, []);

    return (
        <Layout>
            <div className="content-card">
                <h3>Trip History</h3>
                <div className="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Start Location</th>
                                <th>End Location</th>
                                <th>Distance (km)</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {trips.map(t => (
                                <tr key={t.id}>
                                    <td>{t.start_location}</td>
                                    <td>{t.end_location}</td>
                                    <td>{t.distance_km}</td>
                                    <td>
                                        <span className={`status-badge ${t.status === 'IN_PROGRESS' ? 'status-warning' : 'status-active'}`}>
                                            {t.status}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </Layout>
    );
}
export default Trips;
