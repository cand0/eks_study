resource "aws_eks_cluster" "main" {
  name = var.project_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [for subnet_id in module.network.private_subnet_id:subnet_id]
  }
  
    depends_on = [ aws_iam_role.eks_cluster ]

}

output "endpoint" {
    value = aws_eks_cluster.main.endpoint
}

output "kubeconfig-certificate-authority-data" {
    value = aws_eks_cluster.main.certificate_authority[0].data
  
}

