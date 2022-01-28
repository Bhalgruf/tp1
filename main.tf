### Module Main

provider "aws" {
  region = var.aws_region
}

// Creation VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block_demo

  tags = {
    Name = "${var.vpc_name}-vpc"
  }
}


// internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-${var.gw_name}"
  }
}

//ami
data "aws_ami" "ec2_amis" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-2018.03.0.2021*"]
  }
}

//creation public key
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.public_key1
}

//nat
resource "aws_instance" "nat" {

  for_each= toset(var.azs)
  instance_type = "t2.micro"
  ami = data.aws_ami.ec2_amis.id
  subnet_id   = aws_subnet.vpc_public_subnets[each.value].id
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.nat.id]

  tags = {
    Name = "${var.vpc_name}-nat-${var.aws_region}${each.value}"
  }
}
