data "aws_eks_cluster_auth" "main" {
    name = var.project_name
}