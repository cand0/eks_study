terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.14.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-2"
}


provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    host = var.eks_host
    token = var.eks_token
    cluster_ca_certificate = var.eks_cluster_ca_certificate
  }
}
