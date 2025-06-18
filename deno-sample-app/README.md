# Deno Web App

このディレクトリには、Deno を使用したシンプルな Web サーバーの例が含まれています。このアプリを k3s クラスタにデプロイします。

## act による GitHub Actions の検証

[act](https://github.com/nektos/act) を使用して、GitHub Actions ワークフローをローカルで実行・検証できます。

**必要なツール**
- act
- docker

### ローカルモック環境

`docker-compose.yml` を使ってテスト用の最小構成~~ k3s クラスターと~~ローカルコンテナレジストリを起動できます。永続化ボリュームは使用していないため、コンテナを削除するとデータはすべて消えます。
k3sはdockerで上手く動かせなかったので諦めました。

#### 起動

```bash
docker compose up -d
```

#### 停止

```bash
docker compose down
```

### ワークフローの実行
上記のローカルモック環境を起動した状態で、以下のコマンドを実行するとGitHub Actions のワークフローをローカルで実行検証できます。
```bash
deno task test-workflow
```
