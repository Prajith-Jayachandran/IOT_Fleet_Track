import React from 'react';
import { NavLink, useNavigate } from 'react-router-dom';

function Sidebar() {
    const navigate = useNavigate();
    const handleLogout = (e) => {
        e.preventDefault();
        localStorage.removeItem('auth');
        navigate('/login');
    };
    return (
        <aside className="sidebar">
            <div className="sidebar-header">Fleet Command</div>
            <ul className="nav-list">
                <li className="nav-item"><NavLink to="/dashboard" className={({isActive}) => isActive ? "nav-link active" : "nav-link"}>Dashboard</NavLink></li>
                <li className="nav-item"><NavLink to="/vehicles" className={({isActive}) => isActive ? "nav-link active" : "nav-link"}>Vehicles</NavLink></li>
                <li className="nav-item"><NavLink to="/drivers" className={({isActive}) => isActive ? "nav-link active" : "nav-link"}>Drivers</NavLink></li>
                <li className="nav-item"><NavLink to="/tracking" className={({isActive}) => isActive ? "nav-link active" : "nav-link"}>Tracking</NavLink></li>
                <li className="nav-item"><NavLink to="/trips" className={({isActive}) => isActive ? "nav-link active" : "nav-link"}>Trips</NavLink></li>
                <li className="nav-item"><NavLink to="/maintenance" className={({isActive}) => isActive ? "nav-link active" : "nav-link"}>Maintenance</NavLink></li>
                <li className="nav-item"><NavLink to="/analytics" className={({isActive}) => isActive ? "nav-link active" : "nav-link"}>Analytics</NavLink></li>
                <li className="nav-item"><NavLink to="/database" className={({isActive}) => isActive ? "nav-link active" : "nav-link"}>Database (Case Study)</NavLink></li>
                <li className="nav-item" style={{ marginTop: '30px' }}><a href="#" onClick={handleLogout} className="nav-link">Logout</a></li>
            </ul>
        </aside>
    );
}
export default Sidebar;
