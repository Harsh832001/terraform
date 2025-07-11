# Key pair to loging the server
resource "aws_key_pair" "deployer"{
    key_name = "terraform_key"
    public_key = file("terraform_key.pub")
}

# VPC 
resource "aws_default_vpc" "default"{

} 

# Security Group 
resource "aws_security_group" "harsh_sg"{
    name = "terraform-sg"
    description = "This is created by the terraform"
    vpc_id = aws_default_vpc.default.id

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     ingress{
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#Ec2 

resource "aws_instance" "Harsh_ec2"{
    key_name = aws_key_pair.deployer.key_name
    security_groups = [aws_security_group.harsh_sg.name]
    instance_type = "t2.micro"
    ami = "ami-0f918f7e67a3323f0"

    root_block_device{
        volume_size = 15
        volume_type = "gp3"

    }
    tags = {
        Name = "Terraform_Ec2"
    }

}