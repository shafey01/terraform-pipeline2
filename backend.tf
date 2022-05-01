terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-shafey2"
    key    = "terraform2/state2/"
    # dynamodb_table = "terraform-state-lock"

    region = "us-east-1"
  }
}