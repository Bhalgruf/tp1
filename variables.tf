variable "aws_region" {
  type    = string

}

variable "cidr_block_demo" {
  type    = string
  description = "cidr block for my vpc demo"
}

variable "vpc_name" {
  type    = string
  description = "Name for my vpc"
}

variable "azs" {
  type=list(string)
  description = "Map for subnets"
}

variable "gw_name" {
  type    = string
  description = "Name for my gateway"
}

variable "sg1_name" {
  type    = string
  description = "Name for my security group"
}

variable "public_key1" {
  type    = string
  description = "key public 1 for shh"
}

variable "cidr_dest" {
  type    = string
  description = "destination cidr block"
}