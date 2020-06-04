variable "vpc_id" {}
variable "vpc_cidr" {}
variable "private_subnet_id_list" {
  type = list
}


variable "projectName" {
  description = "Project Name"
  type = string
}

variable "environmentName" {
  description = "Environment Name"
  type = string
}

variable "default_tags" {
  description = "Default tags"
  type = map 
  default = {}
}

variable "worker_nodes" {
  description = "Private InBound NACL rules"
  type = list(map(string))
}