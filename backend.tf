terraform {
  backend "s3" {
    bucket       = "gt-bucket-terraform" # replace with your bucket
    key          = "w7/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = false
  }
}