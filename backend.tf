terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-shafey"
    key    = "terraform/state/"
    dynamodb_table = "terraform-state-lock"

    region = "us-east-1"
  }
}