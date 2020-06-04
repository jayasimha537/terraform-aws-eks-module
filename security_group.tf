resource "aws_security_group" "cluster-sg" {
  name        = "eks-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = "${merge(
			"${var.default_tags}", local.custom_tags,
			map(
			  "Name", "${var.projectName}_${var.environmentName}_nat_gw"
			)
		  )}"
}

