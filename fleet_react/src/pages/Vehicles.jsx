import React, { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import api from '../api';

function Vehicles() {
    const [vehicles, setVehicles] = useState([]);

    useEffect(() => {
        api.get('vehicles/').then(res => setVehicles(res.data)).catch(console.error);
    }, []);

    return (
        <Layout>
            <div className="content-card">
                <h3>Fleet Inventory</h3>
                <div className="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Registration</th>
                                <th>Type</th>
                                <th>Model</th>
                                <th>Manufacturer</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {vehicles.map(v => (
                                <tr key={v.id}>
                                    <td>{v.registration_no}</td>
                                    <td>{v.vehicle_type}</td>
                                    <td>{v.model}</td>
                                    <td>{v.manufacturer}</td>
                                    <td>
                                        <span className={`status-badge ${v.status === 'ACTIVE' ? 'status-active' : 'status-warning'}`}>
                                            {v.status}
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
export default Vehicles;
