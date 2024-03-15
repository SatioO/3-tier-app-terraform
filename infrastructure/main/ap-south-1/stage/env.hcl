locals {
    environment        = "accion-stage"
    availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

    vpc_cidr         = "10.0.0.0/16"
    web_subnets_cidr = ["10.0.10.0/24"] //List of web subnet cidr range
    app_subnets_cidr = ["10.0.20.0/24"] //List of app subnet cidr range
    db_subnets_cidr  = ["10.0.30.0/24"] //List of db subnet cidr range
}