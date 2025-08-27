// ec2 instance code
resource "aws_instance" "server" {
  ami                    = "ami-00ca32bbc84273381" // Amazon Linux 2 AMI (HVM), SSD Volume Type - us-east-1
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.pusub1.id
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  key_name               = aws_key_pair.key1.key_name
  user_data              = file("setup.sh")
  tags = {
    Name = "Terra-projectserver"
    env  = "Dev"
    Team = "DevOps"
  }


}
//ebs volume 
resource "aws_ebs_volume" "ebs" {
  availability_zone = aws_instance.server.availability_zone
  size              = 20
  tags = {
    Name = "Terra-ebs-volume"
    env  = "Dev"
    Team = "DevOps"
  }

}
//attach ebs to ec2
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.server.id
}
  