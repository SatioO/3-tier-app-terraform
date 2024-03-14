variable "region" {
  description = "region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "The Deployment environment"
}

variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "web_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the web subnet"
}

variable "app_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the web subnet"
}

variable "db_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the web subnet"
}
