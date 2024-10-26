terraform {
  backend "s3" {
    bucket = "devops-project"
    region = "eu-central-1"
  }
}
