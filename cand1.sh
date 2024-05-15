#!/bin/bash

export TF_VAR_iam_user_id=""
export cluster_name="cand0-eks"

# terraform 경로 찾은 뒤 해당 경로에서 eks 실행
pwd_dir="`pwd`/`dirname $0`/terraform/eks"
cd $pwd_dir
terraform apply --auto-approve


# eks config 파일 수정
aws eks --region ap-northeast-2 update-kubeconfig --name $cluster_name


