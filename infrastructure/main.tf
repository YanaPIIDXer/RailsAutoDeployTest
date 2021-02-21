provider "aws" {
    region = "ap-northeast-1"
}

module "VPC" {
    source = "./VPC"
    name = "deploy_test"
    cidr_block = "10.0.0.0/16"
    public_subnets = [
        {
            cidr_block = "10.0.1.0/24"
            availability_zone = "ap-northeast-1c"
        }
    ]
    private_subnets = [
        {
            cidr_block = "10.0.2.0/24"
            availability_zone = "ap-northeast-1c"
        }
    ]
}

module "RouteTable" {
    source = "./RouteTable"
    name = "deploy_test"
    vpc_id = module.VPC.vpc_id
    subnets = module.VPC.public_subnets
    gateway_routes = [{
        id = module.VPC.internet_gateway_id
        cidr_block = "0.0.0.0/0"
    }]
}

module "SecurityGroup" {
    source = "./SecurityGroup"
    name = "deploy_test"
    vpc_id = module.VPC.vpc_id
    subnets = module.VPC.public_subnets
    gateway_routes = [{
        id = module.VPC.internet_gateway_id
        cidr_block = "0.0.0.0/0"
    }]
    enable_ssh = true
    enable_http = true
}

module "EC2" {
    source = "./EC2"
    name = "deploy_test"
    subnet = module.VPC.public_subnets[0]
    security_groups = [module.SecurityGroup.id]
}
