# Region
variable "region" {
  type = string
  default = "us-east-1"
}
# VPC Module's /  EC2 Security Group variables
variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
variable "enable_nat_gateway" {
  type = bool
}
variable "create_ec2_sg" {
  type = bool
}

variable "ec2_ingress_rules" {
  type = list(object({
  from_port   = number
  to_port     = number
  protocol    = string
  cidr_blocks = list(string)
}))
}

# Elastic IP variable

variable "create_eip" {
  type = bool
}

# DB Port variable

variable "db_port" {
  type = string
}


# EC2 Module's Variables

variable "ami_id" {
  type = string
}
variable "instance_name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "keypair" {
  type = string
}
variable "enable_ssm" {
  type = bool
}
variable "environment" {
  type = string
}


# Private EC2 module"s variables

variable "user_data2" {
  type = string
}
variable "instance_name2" {
  type = string
}