import React, { useEffect, useState } from 'react';
import Layout from '../components/Layout';
import api from '../api';

function Maintenance() {
    const [logs, setLogs] = useState([]);

    useEffect(() => {
        api.get('maintenance/').then(res => setLogs(res.data)).catch(console.error);
    }, []);

    return (
        <Layout>
            <div className="content-card">
                <h3>Maintenance Logs</h3>
                <div className="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Vehicle ID</th>
                                <th>Service Date</th>
                                <th>Description</th>
                                <th>Cost ($)</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {logs.map(log => (
                                <tr key={log.id}>
                                    <td>{log.vehicle}</td>
                                    <td>{log.service_date}</td>
                                    <td>{log.description}</td>
                                    <td>{log.cost}</td>
                                    <td>
                                        <span className={`status-badge ${log.status === 'COMPLETED' ? 'status-active' : 'status-warning'}`}>
                                            {log.status}
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
export default Maintenance;
