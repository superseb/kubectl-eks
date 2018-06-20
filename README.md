# EKS kubectl Docker image

## How to use

By providing the necessary information in environment variables, the kubectl config is automatically completed and you can start using `kubectl` commands straight away. Kubectl config is located at `/root/.kube/config`, template is in this repo called `kubectlconfig`.

```
$ docker run -e AUTOCONFIG=true \
  -e CLUSTER_NAME=your_eks_cluster_name \
  -e AWS_ACCESS_KEY_ID=your_aws_access_key \
  -e AWS_SECRET_ACCESS_KEY=your_aws_secret_key \
  -e AWS_DEFAULT_REGION=your_aws_eks_region \
  -ti superseb/kubectl-eks
CLUSTER_ENDPOINT: "https://xxx"
CLUSTER_BASE64: "LS0..."
bash-4.4# kubectl  get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP   2h
```
