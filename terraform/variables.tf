variable "region" {
  type = string
}
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type = string
}

variable "public_subnet1_cidr" {
  type = string
}

variable "private_subnet1_cidr" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "instance_type" {
  type = string
  #default = "t2.micro"     #expalin variable precidence
}
