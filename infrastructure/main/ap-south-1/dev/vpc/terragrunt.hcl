terraform {
    source = "../../../../../modules/vpc"
}

include "root" {
    path = find_in_parent_folders()
}

include "env" {
    path = find_in_parent_folders("env.hcl")
    expose = true
    merge_strategy = "no_merge"
}

inputs = {
    environment        = include.env.locals.environment
    availability_zones = include.env.locals.availability_zones

    vpc_cidr         = include.env.locals.vpc_cidr
    web_subnets_cidr = include.env.locals.web_subnets_cidr //List of web subnet cidr range
    app_subnets_cidr = include.env.locals.app_subnets_cidr //List of app subnet cidr range
    db_subnets_cidr  = include.env.locals.db_subnets_cidr //List of db subnet cidr range
}