#!/bin/sh
YOUR_SERVER_IP='<your-server-ip>'
DEV_VM_DIR=/opt/setup/dev-vm
# export PORTAINER_PORT=8100
export PORTAINER_AGENT_PORT=9001
echo "🔁 Restarting Docker + Portainer Agent..."

service docker restart

# cd "$DEV_VM_DIR/portainer"
# docker-compose down
# docker-compose up -d

# echo "✅ Portainer restarted on :$PORTAINER_PORT"
# echo "👉 Access at: http://$YOUR_SERVER_IP:$PORTAINER_PORT"

cd "$DEV_VM_DIR/portainer-agent"
docker compose down
docker compose up -d

echo "✅ Portainer Agent restarted on :$PORTAINER_AGENT_PORT"
