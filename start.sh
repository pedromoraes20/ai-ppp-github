#!/bin/bash

# Gracefully kill both background processes on interrupt
trap 'kill %1; kill %2' SIGINT SIGTERM

# Ensure config directory exists
mkdir -p app/streamlit/.streamlit

# Create Streamlit config
cat <<EOF > app/streamlit/.streamlit/config.toml
[server]
runOnSave = true
fileWatcherType = "poll"

[client]
showSidebarNavigation = false

[theme]
base="light"
primaryColor="#257a95"
EOF

# Start the FastAPI or Flask API in background
python app/backend/app.py &

# Change to streamlit directory (no & here)
cd app/streamlit

# Run Streamlit in background on specific port/address
streamlit run app.py --server.port=8000 --server.address=0.0.0.0 &

# Wait for both background jobs
wait