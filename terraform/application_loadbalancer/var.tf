locals {
  service_account_name = "aws-load-balancer-controller"
}

variable "project_name" {
    default = "cand0-eks"
    type = string
  
}

variable "region" {
    type = list
    default = ["ap-northeast-2a", "ap-northeast-2c"]
  
}

variable "public_subnet_name" {
    type = list
    default = ["public-subnet-2a", "public-subnet-2c"]
}


variable "private_subnet_name" {
    type = list
    default = ["private-subnet-2a", "private-subnet-2c"]
}

variable "issuer_url" {
    type = string

}

variable "eks_host" {
    type = string
}
variable "eks_token" {
    type = string
}

variable "eks_cluster_ca_certificate" {
    type = string
}

variable "vpc_id" {
    type = string
}