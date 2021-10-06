# Automating Infrastructure on Google Cloud with Terraform
## Task 1 - Initialize Terraform
```
terraform init
```
## Task 2 - Import terraform
```
terraform import module.instances.google_compute_instance.tf-instance-1 <project_id>/us-central1-a/tf-instance-1
terraform import module.instances.google_compute_instance.tf-instance-1 <project_id>/us-central1-a/tf-instance-2
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
  name          = "<project_id>"
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
    bucket  = "<project_id>"
    prefix  = "terraform/state"
    }
....
}

```
Initialize
```
terraform init
```
## Task 4 - Modify and update infra
navigate to modules/instances/instance.tf replace tf-instance-1 and tf-instance-2 to
```
machine_type = "n1-standard-2"
```
Add following line
```
resource "google_compute_instance" "tf-instance-3" {
  name         = "tf-instance-3"
  machine_type = "n1-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
allow_stopping_for_update = true
}
```
Apply
```
terraform apply
```
## Task 5 - Taint and destroy resources
Taint tf-instance-3
```
terraform taint module.instances.google_compute_instance.tf-instance-3 
```
Plan and apply
```
terraform plan
terraform apply
```
Remove following line
```
resource "google_compute_instance" "tf-instance-3" {
  name         = "tf-instance-3"
  machine_type = "n1-standard-2"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
allow_stopping_for_update = true
}

```
Apply changes
```
terraform apply
```
Intialize and apply
```
terraform init
terraform apply
```
Add zone and network name for tf-instance-1 and tf-instance-2
```
...
zone = var.zone
...
network_interface {
 network = "terraform-vpc"
    subnetwork = "subnet-01"
  }
 ...
```
## Task 6 - Registry
add following line
```
...
module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 2.5.0"

    project_id   = var.project_id
    network_name = "terraform-vpc"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-central1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-central1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        }
    ]
}
```
## Task 7 - Firewall
add following line in main.tf
```
...
resource "google_compute_firewall" "tf-firewall" {
  name    = "tf-firewall"
 network = "projects/<project_id>/global/networks/terraform-vpc"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}
```
Apply
```
terraform apply
```
