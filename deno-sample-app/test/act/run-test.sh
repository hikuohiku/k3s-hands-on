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

act push --env-file "${SCRIPT_DIR}/.env" --secret-file "${SCRIPT_DIR}/.secrets"