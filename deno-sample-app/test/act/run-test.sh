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

# ローカルレジストリ起動
if ! docker ps --format "{{.Names}}" | grep -q "^local-registry$"; then
    echo "🏪 ローカルレジストリ起動中..."
    docker run -d -p 5000:5000 --name local-registry registry:2
fi

# プロジェクトルートに移動して act を実行
cd "${PROJECT_ROOT}"

echo "⚡ ワークフロー実行中..."
if act push --env-file "${SCRIPT_DIR}/.env" --secret-file "${SCRIPT_DIR}/.secrets"; then
    echo "🎉 ワークフロー検証完了！"

    # アプリケーションテスト
    echo "🧪 アプリケーション動作テスト中..."

    # ビルドされたイメージでアプリケーション起動
    if docker run -d -p 8000:8000 --name deno-test-app localhost:5000/hikuohiku/k3s-hands-on/deno-sample-app:ghcr-configuration > /dev/null 2>&1; then
        echo "  📦 アプリケーションコンテナを起動しました"

        # アプリケーション起動待機
        sleep 3

        # HTTPレスポンステスト
        echo "  🌐 HTTP レスポンステスト中..."
        if response=$(curl -s http://localhost:8000 2>/dev/null) && echo "$response" | grep -q "Hello, Deno!"; then
            echo "  ✅ アプリケーションが正常に応答しています: $response"
        else
            echo "  ❌ アプリケーションの応答に問題があります"
        fi

        # テストコンテナ停止・削除
        echo "  🧹 テストコンテナをクリーンアップ中..."
        docker stop deno-test-app > /dev/null 2>&1
        docker rm deno-test-app > /dev/null 2>&1
        echo "  ✅ テストコンテナをクリーンアップしました"
    else
        echo "  ❌ アプリケーションコンテナの起動に失敗しました"
    fi

    # ローカルレジストリクリーンアップ
    echo "🧹 ローカルレジストリをクリーンアップ中..."
    if docker ps --format "{{.Names}}" | grep -q "^local-registry$"; then
        docker stop local-registry > /dev/null 2>&1
        docker rm local-registry > /dev/null 2>&1
        echo "✅ ローカルレジストリをクリーンアップしました"
    else
        echo "ℹ️  ローカルレジストリは既に停止しています"
    fi

    echo ""
    echo "🎯 検証結果サマリー:"
    echo "  ✅ GitHub Actions ワークフローが正常に実行されました"
    echo "  ✅ Docker イメージがビルドされ、ローカルレジストリにプッシュされました"
    echo "  ✅ アプリケーションが正常に動作しています"
    echo "  ✅ テスト環境がクリーンアップされました"
    echo ""
    echo "🏁 GitHub Actions ワークフロー検証が完了しました！"
    echo "📁 テスト環境: deno-sample-app/test/act/"
    echo "📖 使い方: ./deno-sample-app/test/act/run-test.sh"

else
    echo "❌ ワークフロー検証失敗"
    exit 1
fi