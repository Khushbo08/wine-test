resource "aws_db_instance" "default" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.subnet_db_grp.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  storage_encrypted      = false
}

resource "aws_db_subnet_group" "subnet_db_grp" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.public_1.id, aws_subnet.private_1.id]

  tags = {
    Name = "rds-subnet-group"
  }
}