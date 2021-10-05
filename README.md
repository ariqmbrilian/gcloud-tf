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
## Task 3 - Create storage bucket
Add modules in main.tf
```
module "storage" {
  source     = "./modules/storage"
}   
```
Fill storage/storage.tf
```
resource "google_storage_bucket" "storage" {
  name          = "qwiklabs-gcp-01-ffdae0e6175c"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}
```
Initialize and apply
```
terraform init
terraform apply
```
Add remote backend in main.tf
```
terraform {
backend "gcs" {
    bucket  = "qwiklabs-gcp-01-ffdae0e6175c"
    prefix  = "terraform/state"
    }
....
}

```
Initialize
```
terraform init
```
