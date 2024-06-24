resource "aws_iam_instance_profile" "instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}
 
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
 
resource "aws_iam_role_policy_attachment" "rds_readonly" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}
 
resource "aws_iam_role_policy_attachment" "ec2_readonly" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}



resource "aws_instance" "instance-1" {
  ami           = "ami-0e001c9271cf7f3b9"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y openjdk-11-jdk maven git
    cd /home/ubuntu/
    git clone https://github.com/Khushbo08/wine-test.git
    cd wine-test
    source /etc/environment
    echo HOST_URL=${aws_db_instance.default.endpoint} >> /etc/environment 
    sudo mvn clean package && sudo java -jar target/wine-park-0.0.1-SNAPSHOT.jar
  EOF

  
  tags = {
    Name = "backend-instance"
  }

  depends_on = [aws_db_instance.default]

}


