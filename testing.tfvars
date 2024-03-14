//AWS 
region      = "ap-south-1"
environment = "accion-dev"

/* Networking */
vpc_cidr         = "10.0.0.0/16"
web_subnets_cidr = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"] //List of web subnet cidr range
app_subnets_cidr = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"] //List of app subnet cidr range
db_subnets_cidr  = ["10.0.30.0/24", "10.0.31.0/24", "10.0.33.0/24"] //List of db subnet cidr range
