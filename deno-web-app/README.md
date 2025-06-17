# Deno Web App

このディレクトリには、Deno を使用したシンプルな Web
サーバーの例が含まれています。後のステップでこのアプリを k3s
クラスタにデプロイします。

## Deno のインストール

Deno が未インストールの場合は、以下のスクリプトでインストールできます。

```bash
curl -fsSL https://deno.land/install.sh | sh
```

## 実行方法

Deno がインストールされていれば、以下のコマンドでサーバーを起動できます。

```bash
deno run --allow-net main.ts
```

起動後、`http://localhost:8000` にアクセスすると "Hello, Deno!" と表示されます。

## Docker での実行

Docker イメージのビルドと実行例です。

```bash
docker build -t deno-web-app .
docker run -p 8000:8000 deno-web-app
```

コンテナ起動後、`http://localhost:8000` にアクセスすると "Hello, Deno!"
と表示されます。
