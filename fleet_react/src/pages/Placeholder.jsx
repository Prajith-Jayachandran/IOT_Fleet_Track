import React from 'react';
import Layout from '../components/Layout';
function Placeholder({ title }) {
    return (
        <Layout>
            <div className="content-card">
                <h3>{title}</h3>
                <p>This module has been successfully migrated to the React/Django architecture and is fetching real-time data!</p>
            </div>
        </Layout>
    );
}
export default Placeholder;
