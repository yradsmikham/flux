# Custom Flux Metric

Weavework has their own set of instructions for (developing)[https://github.com/weaveworks/flux/blob/master/site/get-started-developing.md] Flux. Here, you will find a slightly different approach that is used to create a custom Flux metric and how to test it.

Before getting started, be sure to follow the steps highlighted in the documentation for [building](https://github.com/weaveworks/flux/blob/master/site/building.md) Flux. It is important to know that Golang is very particular about where to put your repository relative to the `$GOPATH`. This README makes the assumption that you already have access to a Kubernetes cluster with Flux pod running locally.

### Build New Flux Image

This method of testing uses a public (Docker Hub Repository)[https://hub.docker.com/] to store Flux images. So be sure to have the Docker application installed locally, and a Docker account. You will need to login to your Docker account via terminal if this is your first time. You can do this by running `docker login` and providing your credentials.

Every time you make changes to the Flux source code, peform the following steps:

1. run `make` (in the directory that contains the `Makefile`)
2. `docker tag docker.io/weaveworks/flux:latest yradsmikham/flux:latest` (You will need to create a repository for this image in your Docker Hub account beforehand.)
3. `docker push yradsmikham/flux:latest`

### Deploy Flux Image

To redeploy your Flux pod using the new image you just created:

1. Delete the existing deployment of Flux running in your Kubernetes cluster:
    `kubectl delete deployment flux -n flux`

2. In your Flux `deployment.yaml`, update the container image to the Docker image that you just pushed to your Docker Hub (e.g. `yradsmikham/flux:latest`)

NOTE: If you plan on using the `latest` tag to build your images, be sure to set the `imagePullPolicy` to `Always`.

3. Navigate to the path that contains the manifests for Flux and apply the new changes:
    `kubectl apply -f . -n flux`

4. Wait for your old Flux pods to terminate, and the new one to spin up (should only take ~30 seconds)

### Check your Custom Flux Metric in Prometheus

If a new Prometheus metric was created for Flux, you can verify that the metric is receiving data in Prometheus by running the following command:

`kubectl port-forward -n prometheus svc/prometheus-server 8080:80`

Prometheus should be accessible via browser at http://localhost:8080.
