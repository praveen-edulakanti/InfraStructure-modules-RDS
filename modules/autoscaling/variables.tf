variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "AutoScalingLaunchconfig" {
	type = map
}

variable "AutoScalingGrp" {
	type = map
}

variable "private_subnetID" {
	type  = list
}

variable "targetgroup_arn" {
	type  = list
}

variable "LoadBalSecurityGrpID" {
    type = string
}