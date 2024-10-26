# variables.tf

variable "environment" {
  description = "The environment for the deployment (e.g., dev, prod)"
  type        = string
}

variable "image" {
  description = "The Docker image to use"
  type        = string
}
