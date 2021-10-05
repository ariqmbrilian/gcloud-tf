# Automating Infrastructure on Google Cloud with Terraform
## Task 1 - Initialize Terraform
```
terraform init
```
## Task 2 - Import terraform
```
terraform import module.instances.google_compute_instance.tf-instance-1 qwiklabs-gcp-04-6301d462f01b/us-central1-a/tf-instance-1
terraform import module.instances.google_compute_instance.tf-instance-1 qwiklabs-gcp-04-6301d462f01b/us-central1-a/tf-instance-2
terraform plan
terraform apply
```
