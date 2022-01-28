// Creation des subnets privé et public

resource "aws_subnet" "vpc_private_subnets" {
  for_each= toset(var.azs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block_demo, 4, index(var.azs, each.value))
  availability_zone = "${var.aws_region}${each.value}"
  map_public_ip_on_launch=false

  tags = {
    Name = "${var.vpc_name}-private-${var.aws_region}${each.value}"
  }
}

resource "aws_subnet" "vpc_public_subnets" {
  for_each= toset(var.azs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block_demo, 4, 15-index(var.azs, each.value))
  availability_zone = "${var.aws_region}${each.value}"
  map_public_ip_on_launch=true

  tags = {
    Name = "${var.vpc_name}-public-${var.aws_region}${each.value}"
  }
}