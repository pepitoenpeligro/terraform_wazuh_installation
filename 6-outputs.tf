output "dashboard_url"{
    value = "https://${aws_instance.wazuh_dashboard_13700.public_ip}"
}

output "wazuh_dashboard_public_ip" {
  value = aws_instance.wazuh_dashboard_13700.public_ip
}

output "wazuh_indexer_public_ip" {
  value = aws_instance.wazuh_indexer_13700.public_ip
}

output "wazuh_server_public_ip" {
  value = aws_instance.wazuh_server_13700.public_ip
}