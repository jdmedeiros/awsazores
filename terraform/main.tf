# NIC for the Linux Server
resource "aws_network_interface" "lux_server" {
  description = "Linux server network interface"
  private_ip = var.lux_server_private_ip
  private_ips = [
    var.lux_server_private_ip,
  ]
  security_groups = [
    aws_security_group.lux_security_group.id,
  ]
  subnet_id = aws_subnet.lux_network.id
}

# NIC for the Linux Client
resource "aws_network_interface" "lux_client" {
  description = "Linux Client network interface"
  private_ip = var.lux_client_private_ip
  private_ips = [
    var.lux_client_private_ip,
  ]
  security_groups = [
    aws_security_group.lux_security_group.id,
  ]
  subnet_id = aws_subnet.lux_network.id
}

# NIC for the Windows Server
resource "aws_network_interface" "win_server" {
  description = "Windows server network interface"
  private_ip = var.win_server_private_ip
  private_ips = [
    var.win_server_private_ip,
  ]
  security_groups = [
    aws_security_group.win_security_group.id,
  ]
  subnet_id = aws_subnet.win_network.id
}

# NIC for the Windows Client
resource "aws_network_interface" "win_client" {
  description = "Windows client network interface"
  private_ip = var.win_client_private_ip
  private_ips = [
    var.win_client_private_ip,
  ]
  security_groups = [
    aws_security_group.win_security_group.id,
  ]
  subnet_id = aws_subnet.win_network.id
}

# Elastic IP for Linux Server
resource "aws_eip" "lux_server_eip" {
  vpc = true
}

resource "aws_eip_association" "lux_server_eip_assoc" {
  network_interface_id = aws_network_interface.lux_server.id
  allocation_id = aws_eip.lux_server_eip.id
}

# Elastic IP for Linux Client
resource "aws_eip" "lux_client_eip" {
  vpc = true
}

resource "aws_eip_association" "lux_client_eip_assoc" {
  network_interface_id = aws_network_interface.lux_client.id
  allocation_id = aws_eip.lux_client_eip.id
}

# Elastic IP for Windows Server
resource "aws_eip" "win_server_eip" {
  vpc = true
}

resource "aws_eip_association" "win_server_eip_assoc" {
  network_interface_id = aws_network_interface.win_server.id
  allocation_id = aws_eip.win_server_eip.id
}

# Elastic IP for Windows Client
resource "aws_eip" "win_client_eip" {
  vpc = true
}

resource "aws_eip_association" "win_client_eip_assoc" {
  network_interface_id = aws_network_interface.win_client.id
  allocation_id = aws_eip.win_client_eip.id
}

# Create Linux Server
resource "aws_instance" "lux_server" {
  ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name = var.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.lux_server.id
  }

  tags = {
    "Name" = var.lux_server_name
  }

  root_block_device {
    volume_size = var.volume_size
  }
  user_data = data.template_cloudinit_config.config-server.rendered
}

# Create Linux Client
resource "aws_instance" "lux_client" {
  ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.xlarge"
  key_name = var.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.lux_client.id
  }
  tags = {
    "Name" = var.lux_client_name
  }

  root_block_device {
    volume_size = var.volume_size
  }
  user_data = data.template_cloudinit_config.config-client.rendered
}

# Create Windows Server
resource "aws_instance" "win_server" {
  ami = "ami-0fa60543f60171fe3"
  instance_type = "t2.xlarge"
  key_name = var.key_name

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.win_server.id
  }

  tags = {
    "Name" = var.win_server_name
  }

  root_block_device {
    volume_size = var.volume_size
  }
}

# Create Windows Client
resource "aws_instance" "win_client" {
  ami = "ami-06c2b0c7ffeee4e8c"
  instance_type = "t2.xlarge"
  key_name = var.key_name
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.win_client.id
  }
  tags = {
    "Name" = var.win_client_name
  }
}


# Security Group for Linux
resource "aws_security_group" "lux_security_group" {
  vpc_id = aws_vpc.enta_vpc.id
  name = var.lux_security_group_name
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    },
  ]
  ingress = [
  for _fw_rule in var.fw_rules_lux :
  {
    cidr_blocks = [
    for _ip in var.ip_list[_fw_rule[4]] :
    _ip
    ]
    description = _fw_rule[3]
    from_port = _fw_rule[1]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = _fw_rule[0]
    security_groups = []
    self = false
    to_port = _fw_rule[2]
  }
  ]
}


# Security Group for Windows
resource "aws_security_group" "win_security_group" {
  vpc_id = aws_vpc.enta_vpc.id
  name = var.win_security_group_name
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description = ""
      from_port = 0
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol = "-1"
      security_groups = []
      self = false
      to_port = 0
    },
  ]
  ingress = [
  for _fw_rule in var.fw_rules_win :
  {
    cidr_blocks = [
    for _ip in var.ip_list[_fw_rule[4]] :
    _ip
    ]
    description = _fw_rule[3]
    from_port = _fw_rule[1]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = _fw_rule[0]
    security_groups = []
    self = false
    to_port = _fw_rule[2]
  }
  ]
}