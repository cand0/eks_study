module "network" {
  source       = "../network_module"
  project_name = var.project_name
}

module "oidc" {
  source = "../oidc_module"
  issuer_url = aws_eks_cluster.main.identity[0].oidc[0].issuer
  
}