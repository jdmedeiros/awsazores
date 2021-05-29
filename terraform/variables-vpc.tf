variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "lux_cidr_block" {
  default = "10.0.0.0/24"
}

variable "lux_server_private_ip" {
  default = "10.0.0.100"
}

variable "lux_client_private_ip" {
  default = "10.0.0.101"
}

variable "win_server_cidr_block" {
  default = "10.0.1.0/24"
}

variable "win_server_private_ip" {
  default = "10.0.1.100"
}

variable "win_client_private_ip" {
  default = "10.0.1.101"
}