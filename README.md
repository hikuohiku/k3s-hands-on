# k3s-hands-on
k3s hands on

## ローカルモック環境

`docker-compose.yml` を使ってテスト用の最小構成 k3s クラスターとローカルコンテナレジストリを起動できます。永続化ボリュームは使用していないため、コンテナを削除するとデータはすべて消えます。

### 起動

```bash
docker compose up -d
```

### kubeconfig の取得

```bash
docker compose exec k3s cat /etc/rancher/k3s/k3s.yaml > kubeconfig
```

### 停止

```bash
docker compose down
```
