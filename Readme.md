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

Add different splash screen
```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: che-dashboard-customization
  namespace: eclipse-che
  annotations:
    che.eclipse.org/mount-as: subpath
    che.eclipse.org/mount-path: /public/dashboard/assets/branding
  labels:
    app.kubernetes.io/component: che-dashboard-secret
    app.kubernetes.io/part-of: che.eclipse.org
data:
  loader.svg:<splash_screen>
  type: Opaque
EOF
``` 


# Build and run the container
```bash
docker build -t maap-starter .
```

```bash
docker run -it --rm maap-starter bash
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
minikube start --driver=virtualbox --addons=ingress,dashboard --vm=true --memory=16240 --cpus=8 --disk-size=50GB
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
# Plugins

ms-python.python
ms-python.debugpy
ms-toolsai.jupyter
redhat.vscode-yaml
redhat.vscode-commons
redhat.vscode-xml

