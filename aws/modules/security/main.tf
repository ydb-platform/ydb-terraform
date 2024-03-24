resource "aws_security_group" "ydb_intro_sg" {
  name        = "ydb-intro-sg"
  description = "Security group for allowing traffic on ports 21 and 22"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ydb-intro-sg"
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.allow_ports)

  type              = "ingress"
  from_port         = var.allow_ports[count.index]
  to_port           = var.allow_ports[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ydb_intro_sg.id
}

resource "aws_security_group_rule" "dns" {
  count = length(var.allow_ports)

  type              = "ingress"
  from_port         = 65535
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ydb_intro_sg.id
}

resource "aws_security_group_rule" "icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ydb_intro_sg.id
}

resource "aws_security_group_rule" "ydb_ic_ports" {
  type              = "ingress"
  from_port         = 19001
  to_port           = 19001 + var.input_instance_value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ydb_intro_sg.id
}

resource "aws_security_group_rule" "ydb_mon_ports" {
  type              = "ingress"
  from_port         = 8765
  to_port           = 8765 + var.input_instance_value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ydb_intro_sg.id
}

resource "aws_security_group_rule" "ydb_grpc_ports" {
  type              = "ingress"
  from_port         = 2135
  to_port           = 2135 + var.input_instance_value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ydb_intro_sg.id
}

resource "aws_security_group_rule" "out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ydb_intro_sg.id
}