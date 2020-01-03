variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "private_subnetID" {
	type  = list
}

variable "PrivateSecurityGrpID" {
    type = string
}

variable "RdsDatabase" {
   type = map
}