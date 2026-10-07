import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function Login() {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();
    const [error, setError] = useState('');

    const handleLogin = (e) => {
        e.preventDefault();
        if (username === 'PrajithJ' && password === 'QWERTY1234@#!') {
            localStorage.setItem('auth', 'true');
            navigate('/dashboard');
        } else {
            setError('Invalid username or password!');
        }
    };

    return (
        <div style={{ display: 'flex', height: '100vh', alignItems: 'center', justifyContent: 'center' }}>
            <form onSubmit={handleLogin} style={{ background: 'rgba(30, 41, 59, 0.95)', padding: '30px', borderRadius: '8px', textAlign: 'center', width: '350px', boxShadow: '0 4px 6px rgba(0,0,0,0.3)', backdropFilter: 'blur(10px)' }}>
                <h2 style={{marginTop: 0, marginBottom: '20px', color: '#fff'}}>Admin Login</h2>
                <div style={{ marginBottom: '15px', textAlign: 'left' }}>
                    <label style={{color: '#fff', fontSize: '14px', display:'block', marginBottom:'5px'}}>Username</label>
                    <input type="text" value={username} onChange={e => setUsername(e.target.value)} required style={{ padding: '10px', width: '100%', boxSizing: 'border-box', background: '#0f172a', border: '1px solid #334155', color: '#fff', borderRadius: '4px' }}/>
                </div>
                <div style={{ marginBottom: '15px', textAlign: 'left' }}>
                    <label style={{color: '#fff', fontSize: '14px', display:'block', marginBottom:'5px'}}>Password</label>
                    <input type="password" value={password} onChange={e => setPassword(e.target.value)} required style={{ padding: '10px', width: '100%', boxSizing: 'border-box', background: '#0f172a', border: '1px solid #334155', color: '#fff', borderRadius: '4px' }}/>
                </div>
                <button type="submit" style={{ padding: '10px 20px', background: '#3b82f6', color: '#fff', border: 'none', borderRadius: '4px', cursor: 'pointer', width: '100%', fontSize: '16px' }}>Login</button>
                {error && <div style={{ color: '#ef4444', fontSize: '14px', marginTop: '10px' }}>{error}</div>}
            </form>
        </div>
    );
}
export default Login;
