resource "helm_release" "aws-load-balancer-controller" {
    namespace = "kube-system"
    name = "aws-load-balancer-controller"
    chart = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    
    
    
    dynamic "set" {
        for_each = {
          "clusterName" = var.project_name
          "vpcId" = var.vpc_id
          "serviceAccountcreate" = true
          "serviceAccount.name" = local.service_account_name
          "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" = aws_iam_role.AWSLoadBalancerControllerIAMRole.arn
          "region" = "ap-northeast-2"
        }
        content {
          name = set.key
          value = set.value
        }
      
    }
  
}