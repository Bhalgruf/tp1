resource "aws_route_table" "rtpublic" {

  vpc_id = aws_vpc.vpc.id
 
  tags = {
    Name = "${var.vpc_name}-public"
  }
}


resource "aws_route" "Rpublic" {

  route_table_id            = aws_route_table.rtpublic.id
  destination_cidr_block    = var.cidr_dest
  gateway_id = aws_internet_gateway.igw.id
  
}


resource "aws_route_table_association" "asspublic" {
  for_each= toset(var.azs)
  subnet_id      = aws_subnet.vpc_public_subnets[each.value].id
  route_table_id = aws_route_table.rtpublic.id
}