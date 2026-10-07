#!/bin/bash

echo "Starting IoT Fleet Tracking System..."
echo "============================================"

# Function to catch Ctrl+C and gracefully shut down all background processes
cleanup() {
    echo ""
    echo "Shutting down all services..."
    kill $DJANGO_PID
    kill $SIMULATOR_PID
    kill $REACT_PID
    echo "All services stopped. Goodbye!"
    exit
}

# Bind the cleanup function to the SIGINT (Ctrl+C) signal
trap cleanup SIGINT

# 1. Start Django Backend API
echo "[1/3] Starting Django API..."
source venv/bin/activate
python fleet_django/manage.py runserver &
DJANGO_PID=$!

# 2. Start Python IoT Simulator
echo "[2/3] Starting IoT Simulator..."
python fleet_django/manage.py run_iot_simulator &
SIMULATOR_PID=$!

# 3. Start React Frontend
echo "[3/3] Starting React Frontend..."
cd fleet_react
npm run dev &
REACT_PID=$!

echo "============================================"
echo "✅ All services successfully started!"
echo "👉 React Dashboard: http://localhost:5173"
echo "👉 Django API:      http://localhost:8000/api/"
echo ""
echo "Press [Ctrl+C] at any time to stop everything."
echo "============================================"

# Wait forever so the script doesn't exit, keeping the background processes alive
wait
