# python maap starter

A simple program that prints system information to the console.

Create configmap for the sample
```bash
kubectl create configmap getting-started-samples --from-file=maap_sample.json -n eclipse-che
```

Label the configmap
```angular2html
kubectl label configmap getting-started-samples app.kubernetes.io/part-of=che.eclipse.org app.kubernetes.io/component=getting-started-samples -n eclipse-che
```

Delete the configmap
```angular2html
kubectl delete configmap getting-started-samples -n eclipse-che
```

# Build and run the container
```bash
vanilla build -t maap-starter .
```

```bash
vanilla run -it --rm maap-starter bash
```
# ToDo
- [ ] Add more system information
- [ ] Modify Redhat universal base image [DUI](https://github.com/devfile/developer-images)
  - https://github.com/devfile/developer-images
- [ ] Jupyter notebook sample

# Images

Reference image: quay.io/devfile/universal-developer-image:ubi8-latest
#quay.io/igabriel185/maap-default:latest

- for base docker environmental variable needs to be set:
```bash
export WORKSPACE_TYPE=vanilla

```

# TL;DR

## Minikube setup
```bash
minikube start --driver=virtualbox --addons=ingress,dashboard --vm=true --memory=16240 --cpus=8 --disk-size=100GB
```
```bash
minikube addons enable metrics-server
```

```bash
minikube dashboard --url
```

```bash
minikube kubectl -- proxy --address='0.0.0.0' --accept-hosts='^*$'

```
```bash
chectl server:deploy --platform minikube
```

## Setup eclipse che
```bash
kubectl create configmap getting-started-samples --from-file=maap_sample.json -n eclipse-che
```
```bash
kubectl label configmap getting-started-samples app.kubernetes.io/part-of=che.eclipse.org app.kubernetes.io/component=getting-started-samples -n eclipse-che
```


## Build image and push to quay.io
```bash
docker build --no-cache -t maap-ubi8-dev .
```

```bash
docker run docker.io/library/maap-ubi8-dev which python
```

```bash
docker commit <container_id> quay.io/igabriel185/maap-ubi8-dev
```

```bash
docker push quay.io/igabriel185/maap-ubi8-dev
```


# kubectl cheatsheet
```bash
kubectl apply -f ubi8_kube.yaml
```


```bash
kubectl describe pod ubi8-demo
```
