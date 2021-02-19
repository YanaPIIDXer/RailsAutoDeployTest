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
