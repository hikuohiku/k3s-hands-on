# Deno Web App

このディレクトリには、Deno を使用したシンプルな Web サーバーの例が含まれています。後のステップでこのアプリを k3s クラスタにデプロイします。

## Deno のインストール

Deno が未インストールの場合は、以下のスクリプトでインストールできます。

```bash
curl -fsSL https://deno.land/x/install/install.sh | sh
```

インストール後、`~/.deno/bin` を `PATH` に追加してください。

## 実行方法

Deno がインストールされていれば、以下のコマンドでサーバーを起動できます。

```bash
deno run --allow-net main.ts
```

起動後、`http://localhost:8000` にアクセスすると "Hello, Deno!" と表示されます。
