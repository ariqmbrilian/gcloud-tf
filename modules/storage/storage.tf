resource "google_storage_bucket" "storage" {
  name          = "qwiklabs-gcp-01-ffdae0e6175c"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}
