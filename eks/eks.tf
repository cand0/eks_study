resource "aws_eks_cluster" "main" {
  name = var.project_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [for subnet_id in module.network.private_subnet_id:subnet_id]
  }
  
    depends_on = [ aws_iam_role.eks_cluster ]

}

resource "aws_eks_node_group" "main" {
  cluster_name = aws_eks_cluster.main.name
  node_group_name = var.project_name
  node_role_arn = aws_iam_role.node_group.arn
  subnet_ids = module.network.private_subnet_id
  instance_types = ["t3.medium"]
  scaling_config {
    desired_size = 1
    max_size = 2
    min_size = 1
  }

}


output "endpoint" {
    value = aws_eks_cluster.main.endpoint
}

output "kubeconfig-certificate-authority-data" {
    value = aws_eks_cluster.main.certificate_authority[0].data
  
}

