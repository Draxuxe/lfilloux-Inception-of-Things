k3d cluster create iot-cluster
kubectl config use-context k3d-argocluster

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd \
  -p '{"spec": {"type": "NodePort", "ports":[{"port":443,"nodePort":32443,"targetPort":443}]}}'

# admin password = name of the server pod
ARGO_POD=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server \
           -o name | cut -d/ -f2)
kubectl -n argocd logs "argocd-server-$ARGO_POD" | grep 'password: ' | awk '{print $2}'

argocd login localhost:32443 \
  --username admin \
  --password $(kubectl -n argocd get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d) \
  --insecure

kubectl apply -f ./confs/argocd.yaml -n argocd

argocd app sync playground-app
