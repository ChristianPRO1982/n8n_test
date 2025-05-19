#!/bin/bash

ngrok config add-authtoken $NGROK_AUTH_TOKEN

# Start ngrok in the background
ngrok http 5678 --log=stdout > /tmp/ngrok.log &

# Wait for ngrok to generate the public URL
sleep 5
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

# Export webhook URL for n8n
export WEBHOOK_URL=$NGROK_URL

# Launch n8n
n8n
