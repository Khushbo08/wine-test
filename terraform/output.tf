output "backend_instance_public_ip" {
  value = aws_instance.instance-1.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}




