# python maap starter

A simple program that prints system information to the console.

Create configmap for the sample
```bash
kubectl create configmap getting-started-samples --from-file=maap-sample.json -n eclipse-che
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