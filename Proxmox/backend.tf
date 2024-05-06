terraform {
  backend "s3" {
    bucket                      = "hl-tfstate"          # Name of the S3 bucket
    key                         = "k8s-sandbox.tfstate" # Name of the tfstate file
    region                      = "main"                # Region validation will be skipped
    skip_requesting_account_id  = true
    skip_credentials_validation = true # Skip AWS related checks and validations
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true # Enable path-style S3 URLs (https://<HOST>/<BUCKET> https://developer.hashicorp.com/terraform/language/settings/backends/s3#use_path_style
  }
}
