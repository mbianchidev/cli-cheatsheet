# Official documentation here: https://docs.aws.amazon.com/cli/index.html

eksctl create iamserviceaccount \
--name <serviceaccount-name> \
--namespace <namespace> \
--profile <profilo aws> \
--cluster <cluster EKS> \
--attach-policy-arn arn:aws:iam::123456789012:policy/<serviceaccount-name> \
--approve

aws kms decrypt \
  --profile google-saml \
  --key-id alias/de-shops-rds \
  --ciphertext-blob fileb://secrets/production_rds_credentials.yml.encrypted \
  --output text \
  --query Plaintext | base64 -d --decode