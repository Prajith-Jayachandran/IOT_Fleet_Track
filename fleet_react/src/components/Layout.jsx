import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Sidebar from './Sidebar';

function Layout({ children }) {
    const navigate = useNavigate();

    useEffect(() => {
        if (!localStorage.getItem('auth')) {
            navigate('/login');
        }
    }, [navigate]);

    return (
        <div className="app-container">
            <Sidebar />
            <div className="main-wrapper">
                {children}
            </div>
        </div>
    );
}

export default Layout;
