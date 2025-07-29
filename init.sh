#!/bin/sh
set -e

if [[ $EUID -ne 0 ]]; then
  echo "❌ Please run this script as root (use: sudo bash $0)"
  exit 1
fi

GIT_USER=saintkim12
GIT_REPO=onyu-home-dev-vm
GIT_BRANCH=main
GIT_URL=https://github.com/${GIT_USER}/${GIT_REPO}.git
DEV_VM_DIR=/opt/setup/dev-vm
YOUR_SERVER_IP='<your-server-ip>'

mkdir -p /opt/setup
cd /opt/setup

### [1] Debian 패키지 및 Docker 설치
echo "📦 Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    git \
    lsb-release

echo "🔑 Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "📦 Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "📦 Installing Docker Engine & Docker Compose..."
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🔌 Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "✅ Docker installed successfully!"
docker --version
docker compose version

echo "📥 Cloning Git repository..."

### [2] Git 저장소 클론
if [ ! -d "$DEV_VM_DIR" ]; then
  git clone -b "$GIT_BRANCH" "$GIT_URL" DEV_VM_DIR
else
  echo "📦 Repo exists, pulling latest..."
  cd $DEV_VM_DIR && git pull && cd ..
fi

### [3] 메인 디렉토리로 이동
cd $DEV_VM_DIR

### [4] Portainer Agent Docker 컨테이너 실행
echo "🚀 Starting Portainer Agent..."
cd portainer-agent
export PORTAINER_AGENT_PORT=9001
docker-compose up -d

echo "✅ Portainer Agent started on :$PORTAINER_AGENT_PORT"
# echo "👉 Access at: http://$YOUR_SERVER_IP:$PORTAINER_AGENT_PORT"

echo ""
echo "📝 Next Step:"
echo "1. Open Portainer UI"
echo "2. Add this Portainer Agent in Environments"

