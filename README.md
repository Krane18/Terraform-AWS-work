# Terraform-AWS-work

** Creating a EC2 instances using Terraform**

    resource "aws_instance" "example" {
        ami                         = "ami-0c55b159cbfafe1f0"
        instance_type               = "t2.micro"
        vpc_security_group_ids      = [aws_security_group.instance.id] 


        user_data = <<-EOF
                    #!/bin/bash
                    echo "Hello World!" > index.html
                    nohup busybox httpd -f -p 8080 &
                    EOF

        Tags = {
            Name = "terraform-example"
        }
    }

#Create security group to allow EC2 to receive traffic on 8080

    resource "aws_security_group" "instance" {
    name "terraform-example-instance"

    ingress {
        from_port   = 8080
        to_port     =3030
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
