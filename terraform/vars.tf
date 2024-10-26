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
  default     = "vpc-055e616d4960ba5c2" # Update this to your actual VPC ID
}
