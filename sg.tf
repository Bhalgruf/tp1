
//security group

resource "aws_security_group" "nat" {
  name        = "nat"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-${var.sg1_name}"
  }

}
//security group rule for connection 

resource "aws_security_group_rule" "sg" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_block_demo]
  security_group_id = aws_security_group.nat.id

}

resource "aws_security_group_rule" "port22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_dest]
  security_group_id = aws_security_group.nat.id

}

