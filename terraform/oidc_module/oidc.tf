# ref : https://github.com/hashicorp/terraform-provider-aws/issues/10104

data "aws_region" "current" {}
data "external" "thumbprint" {
  program = ["${path.module}/get_thumbprint.sh", "${data.aws_region.current.name}"]
}

resource "aws_iam_openid_connect_provider" "main" {
    client_id_list = ["sts.amazonaws.com"]
    thumbprint_list = [data.external.thumbprint.result.thumbprint]
    url = var.issuer_url
}


output "test" {
  value = aws_iam_openid_connect_provider.main
}