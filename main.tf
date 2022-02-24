provider "aws" {
        region      = "us-east-1"
        access_key  = "example_key"
        secret_keY  = "secret key"

    resource "aws_instance" "terraform-instance-master" {
        ami                         = "ami-0c55b159cbfafe1f0"
        instance_type               = "t2.micro"
        vpc_security_group_ids      = [aws_security_group.instance.id] 

#Execute Hello world afer ec2 is created
        user_data = <<-EOF
                    #!/bin/bash
                    echo "Hello World!" > index.html
                    nohup busybox httpd -f -p 8080 &
                    EOF

        Tags = {
            Name = "terraform-instance-master"
        }
    }

# Create security group to allow EC2 to receive traffic on 8080

    resource "aws_security_group" "terraform-instance-master" {
    name "terraform-security-group-ec2"

    ingress {
        from_port   = 8080
        to_port     = 3030
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}