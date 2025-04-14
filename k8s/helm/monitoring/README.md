# Deploying Monitoring Stack with Helm

## 1. Create a Namespace
```sh
kubectl create namespace monitoring
```

## 2. Install Prometheus

Add the Prometheus Helm chart repository:
```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```
Install Prometheus in the `monitoring` namespace:
```sh
helm upgrade --install prometheus prometheus-community/prometheus --namespace monitoring --set server.persistentVolume.enabled=false --set alertmanager.enabled=false
```
Verify the installation:
```sh
kubectl get pods -n monitoring
```

## 3. Install Grafana

Add the Grafana Helm chart repository:
```sh
helm repo add grafana https://grafana.github.io/helm-charts
```
Install Grafana in the `monitoring` namespace:
```sh
helm install grafana grafana/grafana --namespace monitoring
```
Retrieve the Grafana admin password:
```sh
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```
Expose Grafana service using k8s port-forward method
```sh
kubectl port-forward svc/grafana 3000:80 -n monitoring
```

## 4. Configure Grafana

### Add Prometheus as a Data Source
In Grafana, configure Prometheus as the data source.

### Import JVM Metrics Dashboard
To monitor JVM metrics, import Dashboard ID **4701** from Grafana:
🔗 [JVM Micrometer Dashboard](https://grafana.com/grafana/dashboards/4701-jvm-micrometer/)

