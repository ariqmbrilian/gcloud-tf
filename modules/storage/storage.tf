resource "google_storage_bucket" "storage" {
  name          = "<project_id>"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}
