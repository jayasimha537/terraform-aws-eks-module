resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.projectName}_${var.environmentName}_eks_cluster"
  role_arn = aws_iam_role.cluster-iam-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.cluster-sg.id]
    subnet_ids         = var.private_subnet_id_list
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
  ]
}