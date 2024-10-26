variable "environment" {
  type        = string
  description = "Deployment Environment Name"
}

variable "image" {
  type        = string
  description = "Image URI"
}

variable "vpc_id" {
  type        = string
  description = "Deployment VPC ID"
  default     = "vpc-01d6a0f32512b0b6d" # Update this to your actual VPC ID
}
