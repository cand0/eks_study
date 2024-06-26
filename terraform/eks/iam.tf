data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "${var.project_name}-cluster"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role" "node_group" {
  name = "eks-node-group"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "node_group-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "node_group-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

# resource "aws_iam_role" "cand0" {
#   name = var.project_name
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = "1"
#         Principal = {
#           "AWS" : var.iam_user_id
#         }
#       },
#     ]
#   })
#   tags = {
#     Name = var.project_name
#   }
# }

# resource "aws_iam_policy_attachment" "EksServicePolicy" {
#   name = "cand1-EksServicePolicy"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#   roles = [aws_iam_role.cand0.name]
# }

# resource "aws_iam_policy_attachment" "EKSClusterPolicy" {
#   name = "cand1-EKSClusterPolicy"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   roles = [aws_iam_role.cand0.name]  
# }