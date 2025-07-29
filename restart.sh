#!/bin/sh
YOUR_SERVER_IP='<your-server-ip>'
DEV_VM_DIR=/opt/setup/dev-vm
echo "🔁 Restarting Docker + Portainer Agent..."

service docker restart

cd "$DEV_VM_DIR/portainer-agent"
docker compose down
docker compose up -d

echo "✅ Portainer Agent re-started on :$PORTAINER_AGENT_PORT"
