# Migrate from Heroku to the cloud using Kubernetes

[DockerHub repo](https://hub.docker.com/r/mclacore/haiku-havoc-hero)

## Overview

These Docker images are useful for migrating data from Heroku to the cloud, such as PostgresQL databases and Redis caches. You can install any tool needed to aid your migration:

- `heroku`
- `curl`
- `psql`, `pg_restore`
- `mysql`,
- `mongosh`
- `sqlcmd`
- `redis-cli`
- `aws-cli`, `az`, `gcloud`

## Usage

1. Make a new manifest file:

```bash
touch haiku-havoc-hero.yaml
```

2. Comment out the containers you don't need:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: haiku-havoc-hero
  namespace: default
spec:
  containers:
    - name: postgres
      image: mclacore/haiku-havoc-hero:postgres-v1
      env:
        - name: POSTGRES_PASSWORD
          value: password
    - name: mysql
      image: mclacore/haiku-havoc-hero:mysql-v1
      env:
        - name: MYSQL_ROOT_PASSWORD
          value: password
    - name: redis
      image: mclacore/haiku-havoc-hero:redis-v1
    - name: mongo
      image: mclacore/haiku-havoc-hero:mongo-v1
    - name: mssql
      image: mclacore/haiku-havoc-hero:mssql-v1
      env:
        - name: PATH
          value: "/opt/mssql-tools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/tmp/google-cloud-sdk/bin"
```

3. Apply the manifest:

```bash
kubectl apply -f haiku-havoc-hero.yaml
```

4. Get a shell in the container:

```bash
kubectl exec -it haiku-havoc-hero -c <container-name> -- sh
```

5. Log into Heroku using `-i` for interactive mode and use your API key as the password:

```bash
heroku login -i
```

For an in-depth migration guide, see [Migrate from Heroku to Azure](https://github.com/mclacore/heroku-to-azure).
