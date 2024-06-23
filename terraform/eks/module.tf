module "network" {
  source       = "../network_module"
  project_name = var.project_name
}

module "oidc" {
  source = "../oidc_module"
  issuer_url = aws_eks_cluster.main.identity[0].oidc[0].issuer
  
}

module "application_loadbalancer" {
  source = "../application_loadbalancer"
  issuer_url = aws_eks_cluster.main.identity[0].oidc[0].issuer
  eks_host = aws_eks_cluster.main.endpoint
  eks_token    = data.aws_eks_cluster_auth.main.token
  eks_cluster_ca_certificate = base64decode(aws_eks_cluster.main.certificate_authority[0].data)
  vpc_id = module.network.vpc_id
}


