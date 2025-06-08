resource "aws_instance" "ec2_data_integration_wc" {
    ami           = var.ami
    instance_type = var.instance_type
    key_name      = var.key_name
    subnet_id     = var.subnet_id

    tags          = var.tags

    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 8
      volume_type = "gp3"
    }

    vpc_security_group_ids = [var.security_group_id]
}

resource "aws_eip" "ec2_eip" {
  vpc      = true
  depends_on = [aws_instance.ec2_data_integration_wc]
}

resource "aws_eip_association" "ec2_eip_assoc" {
  instance_id   = aws_instance.ec2_data_integration_wc.id
  allocation_id = aws_eip.ec2_eip.id
}