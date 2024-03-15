variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "environment" {
  description = "The Deployment environment"
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

variable "availability_zones" {
  type        = list(any)
  description = "The az that the resources will be launched"
}
