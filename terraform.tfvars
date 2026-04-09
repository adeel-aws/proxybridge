# VPC variables

vpc_name = "My-VPC"
vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
azs = ["us-east-1a", "us-east-1b"]
enable_nat_gateway = true
create_ec2_sg = true
create_eip = true
db_port = "80"
 ec2_ingress_rules = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["182.189.9.19/32"] },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 8080, to_port = 8080, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]

# EC2 variables

ami_id = "ami-0ec10929233384c7f"
instance_name = "Proxy-Instance"
keypair = "MYKEY"
enable_ssm = true
instance_type = "t3.micro"
environment = "Dev"

# Private EC2

instance_name2 = "Private-Instance"