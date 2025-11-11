output "website_url" {
  value       = "http://${aws_instance.web_server.public_ip}"
  description = "Public URL of the Imusafe LGU Website"
}

output "ip_address" {
  value       = aws_instance.web_server.public_ip
  description = "Public IP address of the Imusafe Web Server (dynamic)"
}
