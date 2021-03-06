variable "lux_server_name" {
  type = string
  default = "luxsrv"
}

variable "lux_client_name" {
  type = string
  default = "luxcli"
}

variable "win_server_name" {
  type = string
  default = "winsrv"
}

variable "win_client_name" {
  type = string
  default = "wincli"
}

variable "key_name" {
  type = string
  default = "Sample-key-pair"
}

variable "volume_size" {
  type = number
  default = 30
}

variable "lux_security_group_name" {
  type = string
  default = "Linux security group to allow SSH, HTTP, HTTPS and RDP"
}

variable "win_security_group_name" {
  type = string
  default = "Windows security group to allow RDP"
}

variable "cloud_config-client" {
  type = string
  default = "cloud-config-client.sh"
}

variable "cloud_config-server" {
  type = string
  default = "cloud-config-server.sh"
}

variable "fw_rules_lux" {
  description = "Firewall rules"
  #                  Protocol [-1 for all traffic or protocol such as tcp, udp, etc]
  #                  |       From port [0 for all ports]
  #                  |       |       To port [0 for all ports]
  #                  |       |       |       Description
  #                  |       |       |       |       Link to ip_list entry
  #                  |       |       |       |       |
  type = list(tuple([string, number, number, string, number]))
  default = [
    ["tcp", 22, 22, "Allow SSH", 0],
    ["tcp", 3389, 3389, "Allow RDP", 0],
    ["tcp", 80, 80, "Allow HTTP", 1],
    ["tcp", 443, 443, "Allow HTTP", 1],
  ]
}

variable "fw_rules_win" {
  description = "Firewall rules"
  #                  Protocol [-1 for all traffic or protocol such as tcp, udp, etc]
  #                  |       From port [0 for all ports]
  #                  |       |       To port [0 for all ports]
  #                  |       |       |       Description
  #                  |       |       |       |       Link to ip_list entry
  #                  |       |       |       |       |
  type = list(tuple([string, number, number, string, number]))
  default = [
    ["tcp", 22, 22, "Allow SSH", 2],
    ["tcp", 80, 80, "Allow HTTP", 1],
    ["tcp", 443, 443, "Allow HTTPS", 1],
    ["tcp", 3389, 3389, "Allow RDP", 2],
  ]
}

variable "ip_list" {
  description = "Allowed IPs"
  type = list(list(string))
  default = [
    ["128.65.243.205/32"],
    ["128.65.243.205/32", "10.0.0.0/8"],
    ["0.0.0.0/0"],
  ]
}
