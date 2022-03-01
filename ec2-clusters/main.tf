provider "aws" {
        region      = "us-east-1"
        access_key  = "example_key"
        secret_keY  = "secret key"

    resource "aws_launch_configuration" "my-ec2-cluster-terra" {
        image_id            = "ami-048ff3da02834afdc"
        instance_type       = "t2.micro"
        aws_security_group  = "my-aws_security_group_instance.id"

        user_data = <<-EOF
                    #!/bin/bash
                    echo "Hello World!! > index.html
                    nohup busybox httpd -f -p ${var.server_port} &
                    EOF

    #Required when using a launch confiration with an auto scaling group.
        lifecycle {
            create_before_destroy = true
        }
 
    }
}

    resource "aws_autoscaling_group" "my-ec2-autoscalling_group" {
      launch_configuration      = aws_launch_configuration.name
      vpc_zone_identifier       = data.aws_subnet_ids.default.ids

      min_size = 2
      max_size = 10

      tag {
        key                 = "Name"
        value               = "terraform-asg-example"
      }    

    }