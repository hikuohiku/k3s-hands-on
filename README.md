# k3s-hands-on

このリポジトリには、Deno 製のサンプル Web アプリと k3s 用マニフェストが含まれています。

## デプロイ方法

k3s または通常の Kubernetes クラスタに対して次のコマンドでデプロイできます。

```bash
kubectl apply -f k8s/deno-web-app.yaml
```

デプロイ後、ClusterIP サービス `deno-web-app` が port 80 で公開されます。

