locals {
  custom_tags = {
    "project" = "${var.projectName}",
    "envronment" = "${var.environmentName}"
  }
}