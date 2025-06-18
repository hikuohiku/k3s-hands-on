# GitHub Actions ローカル検証

## 使い方

1. **初回セットアップ**
   ```bash
   # GitHub Personal Access Token を取得
   # https://github.com/settings/tokens (権限: public_repo)

   # トークンを設定
   cp .secrets.template .secrets
   # .secrets を編集してトークンを設定
   ```

2. **検証実行**
   ```bash
   ./run-test.sh
   ```

## ファイル説明

- `.actrc` - act設定
- `.env.template` - 環境変数テンプレート
- `.secrets.template` - トークン設定テンプレート
- `run-test.sh` - 実行スクリプト