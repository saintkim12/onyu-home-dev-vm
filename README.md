# Dev VM

개발 및 테스트용 가상머신 설정

## 구성

- **Portainer Agent**: Docker 컨테이너 관리 (포트 9001)
- **Docker & Docker Compose**: 컨테이너 환경

## 시작하기

```bash
# 실행스크립트
curl -s https://raw.githubusercontent.com/saintkim12/onyu-home-dev-vm/main/init.sh | sudo bash
```

## 서비스

| 서비스 | 포트 | 설명 |
|--------|------|------|
| Portainer Agent | 9001 | Docker 컨테이너 관리 에이전트 |

## 다음 단계

1. Portainer UI 접속
2. Environments에서 Portainer Agent 추가
