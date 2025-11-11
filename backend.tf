terraform {
  backend "s3" {
    bucket = "terraform-bucket-ashour-2025"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

