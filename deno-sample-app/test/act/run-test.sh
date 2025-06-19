#!/bin/bash

# GitHub Actions ワークフロー検証スクリプト
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../../.." && pwd)"

echo "🚀 GitHub Actions ワークフロー検証開始..."

# 設定ファイルをtest/act内に準備
cd "${SCRIPT_DIR}"

[ ! -f .env ] && cp .env.template .env
if [ ! -f .secrets ]; then
    cp .secrets.template .secrets
    echo "⚠️  ${SCRIPT_DIR}/.secrets に GitHub Personal Access Token を設定してください"
    exit 1
fi

# プロジェクトルートに移動して act を実行
cd "${PROJECT_ROOT}"

KUBECONFIG_DATA=$(docker compose -f deno-sample-app/docker-compose.yml exec k3s-server cat /etc/rancher/k3s/k3s.yaml | base64 -w 0)

act push --env-file "${SCRIPT_DIR}/.env" --secret-file "${SCRIPT_DIR}/.secrets" --secret "KUBECONFIG_DATA=${KUBECONFIG_DATA}"