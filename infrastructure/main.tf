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
            availability_zone = "ap-northeast-1a"
        },
        {
            cidr_block = "10.0.3.0/24"
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

module "SecurityGroup_ECS" {
    source = "./SecurityGroup"
    name = "deploy_test_ecs"
    vpc_id = module.VPC.vpc_id
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
    security_groups = [module.SecurityGroup_ECS.id]
    key_name = "key"
}

module "SecurityGroup_RDS" {
    source = "./SecurityGroup"
    name = "deploy_test_rds"
    vpc_id = module.VPC.vpc_id
    enable_ssh = true
    enable_mysql = true
}

module "RDS" {
    source = "./RDS"
    name = "deploy_test"
    identifier = "deploy-test"
    subnets = [module.VPC.private_subnets[0].id, module.VPC.private_subnets[1].id]
    db_name = "deploy_test"
    root_data = {
        name = "root"
        password = "password"
    }
    security_groups = [module.SecurityGroup_RDS.id]
}
