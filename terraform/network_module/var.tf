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

