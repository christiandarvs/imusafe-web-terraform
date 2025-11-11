resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.instance_type
  #   key_name        = "your-keypair-name"
  vpc_security_group_ids = [aws_security_group.allow_access.id]

  user_data = <<-EOF
              #!/bin/bash
              set -e

              # Update & install Nginx and Git
              apt-get update -y
              apt-get install -y nginx git

              # Remove default site files and Nginx default config
              rm -rf /var/www/html/*
              rm -f /etc/nginx/sites-enabled/default

              # Clone your GitHub repository
              git clone https://github.com/christiandarvs/imusafe-lgu-website.git /var/www/html

              # Set permissions
              chown -R www-data:www-data /var/www/html
              chmod -R 755 /var/www/html

              # Create a new simple Nginx site config
              cat <<EOT > /etc/nginx/sites-available/imusafe.conf
              server {
                  listen 80;
                  server_name _;
                  root /var/www/html;
                  index index.html index.htm;

                  location / {
                      try_files \$uri \$uri/ =404;
                  }
              }
              EOT

              ln -s /etc/nginx/sites-available/imusafe.conf /etc/nginx/sites-enabled/

              # Test config and restart Nginx
              nginx -t
              systemctl enable nginx
              systemctl restart nginx
              EOF


  tags = {
    Name = "Imusafe-Web-Server"
  }
}

resource "aws_security_group" "allow_access" {
  name        = "allow_internet_access"
  description = "Allow HTTP and SSH inbound traffic"

  # Allow HTTP (port 80) from all listed IPs
  dynamic "ingress" {
    for_each = var.mobile_ip
    content {
      description = "Allow HTTP from trusted IP ${ingress.value}"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["${ingress.value}/32"]
    }
  }

  # Allow SSH (port 22) from all listed IPs
  dynamic "ingress" {
    for_each = var.mobile_ip
    content {
      description = "Allow SSH from trusted IP ${ingress.value}"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${ingress.value}/32"]
    }
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

