output "lux_server_eip" {
  description = "Linux Server Public IP: "
  value = aws_eip.lux_server_eip.public_ip
}

output "lux_client_eip" {
  description = "Linux Server Public IP: "
  value = aws_eip.lux_client_eip.public_ip
}

output "win_server_eip" {
  description = "Windows Server Public IP: "
  value = aws_eip.win_server_eip.public_ip
}

output "win_client_eip" {
  description = "Windows Client Public IP: "
  value = aws_eip.win_client_eip.public_ip
}
