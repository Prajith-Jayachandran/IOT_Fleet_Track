import React, { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import api from '../api';

function Drivers() {
    const [drivers, setDrivers] = useState([]);

    useEffect(() => {
        api.get('drivers/').then(res => setDrivers(res.data)).catch(console.error);
    }, []);

    return (
        <Layout>
            <div className="content-card">
                <h3>Driver Roster</h3>
                <div className="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>License Number</th>
                                <th>Phone</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {drivers.map(d => (
                                <tr key={d.id}>
                                    <td>{d.first_name} {d.last_name}</td>
                                    <td>{d.license_number}</td>
                                    <td>{d.phone}</td>
                                    <td>
                                        <span className={`status-badge ${d.status === 'AVAILABLE' ? 'status-active' : 'status-warning'}`}>
                                            {d.status}
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
export default Drivers;
