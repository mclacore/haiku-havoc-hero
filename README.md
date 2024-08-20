# Migrate from Heroku to the cloud using Kubernetes

This Docker image is useful for migrating data from Heroku to the cloud, such as PostgresQL databases and Redis caches. It installs several tools to aid your migration:

- heroku
- curl
- psql
- pg_restore
- redis-cli
- aws-cli
- az
- gcloud

1. (Optional) Clone this repository and modify the Dockerfile to include or exclude the tools you need. Then build and push the image to your container registry. _If cloned, replace `mclacore` with your container registry username._

2. Apply this Kubernetes manifest to create a pod that uses the image:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: haiku-havoc-hero-pod
  namespace: default
spec:
  containers:
    - name: haiku-havoc-hero-container
      image: mclacore/haiku-havoc-hero:latest
      env:
        - name: POSTGRES_PASSWORD # Required for psql and pg_restore
          value: password
```

```bash
kubectl apply -f /path/to/manifest.yaml
```
