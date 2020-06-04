
variable "public_inbound_acl_rules" {
  description = "Public InBound NACL rules"
  type = list(map(string))
}

variable "public_outbound_acl_rules" {
  description = "Public OutBound NACL rules"
  type = list(map(string))
}

variable "private_inbound_acl_rules" {
  description = "Private InBound NACL rules"
  type = list(map(string))
}

variable "private_outbound_acl_rules" {
  description = "Private OutBound NACL rules"
  type = list(map(string))
}

