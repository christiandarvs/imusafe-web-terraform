variable "region" {
  description = "Region of the AWS"
  type        = string
  default     = "ap-southeast-2"
}

variable "ami" {
  description = "AMI of the EC2 Instance"
  type        = string
  default     = "ami-0279a86684f669718"
}

variable "instance_type" {
  description = "Instance Type of EC2 Instance"
  type        = string
  default     = "t2.micro"
}

variable "mobile_ip" {
  description = "IP Address of my mobile data"
  type        = list(string)
  default     = ["103.16.168.34", "180.190.133.173", "158.62.1.79"]
}
