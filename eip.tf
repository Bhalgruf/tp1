
//eip
resource "aws_eip" "lb" {
  for_each= toset(var.azs)
  instance = aws_instance.nat[each.value].id
  vpc      = true

  tags = {
    Name = "${var.vpc_name}-lb-${var.aws_region}${each.value}"
  }
}

resource "aws_eip_association" "eip_assoc" {
   for_each= toset(var.azs)
  instance_id   = aws_instance.nat[each.value].id
  allocation_id = aws_eip.lb[each.value].id
}