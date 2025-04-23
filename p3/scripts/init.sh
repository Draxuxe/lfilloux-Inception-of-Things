k3d cluster create iot-cluster --wait

kubectl create namespace argocd
kubectl create namespace dev

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argocd -f ./confs/argocd.yaml

kubectl patch svc argocd-server -n argocd \
  -p '{"spec": {"type": "NodePort", "ports": [{"port": 443, "nodePort": 32443, "targetPort": 8080}]}}'

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > .argocd_pass

kubectl wait --for=condition=Ready pods --all -n argocd
kubectl -n argocd port-forward svc/argocd-server 8080:443 > /dev/null 2>&1 &

kubectl port-forward svc/wil-service -n dev 8888:8888
