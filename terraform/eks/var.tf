variable "project_name" {
  type    = string
  default = "cand0-eks"
}

# variable "cluster_version" {
#   type    = string
#   default = null
# }

variable "iam_user_id" {
  type = string
  # Access Key 를 가지고 있는 USER ARN
  # Example arn:aws:iam::[AccountID]:user/[UserName]
}