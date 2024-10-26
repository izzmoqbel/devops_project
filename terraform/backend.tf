terraform {
  backend "s3" {
    bucket = "devops-course-tf-state"
    region = "eu-central-1"
  }
}
