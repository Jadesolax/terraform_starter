# For kubectl to be able to interact with eks cluster
aws eks --region <region> update-kubeconfig --name <cluster-name>

create manifest
kubectl apply -f .....

# To expose deployment to ELB
kubectl expose deployment nginx-deployment --type=LoadBalancer --name=nginx-service --port=80 --target-port=80

kubectl get svc
kubectl describe 


# To automate the manifest application process within your Terraform workflow, you can use the kubectl provider or execute a local-exec provisioner.

resource "null_resource" "apply_manifest" {
  provisioner "local-exec" {
    command = "kubectl apply -f ./nginx-deployment.yaml"
    environment = {
      KUBECONFIG = "${path.module}/kubeconfig" # Point to the kubeconfig file if needed
    }
  }

  depends_on = [aws_eks_cluster.your_cluster, aws_eks_node_group.your_node_group]
}
