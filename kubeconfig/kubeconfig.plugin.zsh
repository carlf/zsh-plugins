KUBECONFIG=""
for C in `ls ~/.kube/configs`; do
    KUBECONFIG=$KUBECONFIG:~/.kube/configs/$C
done
export KUBECONFIG
