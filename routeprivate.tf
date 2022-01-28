resource "aws_route_table" "rtprivate" {
  
  vpc_id = aws_vpc.vpc.id


  for_each= toset(var.azs)
  tags = {
    Name = "${var.vpc_name}-private-${var.aws_region}${each.value}"
  }
}

resource "aws_route" "Rprivate" {

  for_each= toset(var.azs)
  route_table_id            = aws_route_table.rtprivate[each.value].id
  destination_cidr_block    = var.cidr_dest
  gateway_id = aws_internet_gateway.igw.id

}

resource "aws_route_table_association" "assprivate" {
  for_each= toset(var.azs)
  subnet_id      = aws_subnet.vpc_private_subnets[each.value].id
  route_table_id = aws_route_table.rtprivate[each.value].id
}