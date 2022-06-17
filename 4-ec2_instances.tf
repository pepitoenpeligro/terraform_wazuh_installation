# Wazuh Indexer EC2 Instance
resource "aws_instance" "wazuh_indexer_13700" {
    ami           = data.aws_ami.amzn2.id # "ami-0c1bc246476a5572b"
    instance_type = "t3.xlarge"
    security_groups = [ "${aws_security_group.security_group_13700.name}"]
    key_name = aws_key_pair.aws_key_indexer.key_name
    associate_public_ip_address = true


    # subnet_id = aws_subnet.public-eu-west-1a.id

    root_block_device {
        volume_size           = 20
        volume_type           = "gp3"
        delete_on_termination = true
    }
    
    
    tags = {
        Name = "wazuh_indexer_13700"
    }


    credit_specification {
        cpu_credits = "standard"
    }

    provisioner "file" {
        source      = "configure-indexer.yml"
        destination = "/home/ec2-user/configure-indexer.yml"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.indexer_key.private_key_pem
            
        }
        
    }


    # aws_key_indexer.pem 
    provisioner "file" {
        source      = "aws_key_indexer.pem"
        destination = "/home/ec2-user/aws_key_indexer.pem"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.indexer_key.private_key_pem
            
        }
    }

    # aws_key_indexer.pem.pub
    provisioner "file" {
        source      = "aws_key_indexer.pem.pub"
        destination = "/home/ec2-user/aws_key_indexer.pem.pub"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.indexer_key.private_key_pem
        }
    }

    # aws_key_dashboard.pem 
    provisioner "file" {
       source      = "aws_key_dashboard.pem"
        destination = "/home/ec2-user/aws_key_dashboard.pem"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.indexer_key.private_key_pem
        }
    }

    # aws_key_dashboard.pem.pub
    provisioner "file" {
       source      = "aws_key_dashboard.pem.pub"
        destination = "/home/ec2-user/aws_key_dashboard.pem.pub"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.indexer_key.private_key_pem
        }
    }

    # aws_key_server.pem 
    provisioner "file" {
       source      = "aws_key_server.pem"
        destination = "/home/ec2-user/aws_key_server.pem"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.indexer_key.private_key_pem
        }
    }


    # aws_key_server.pem 
    provisioner "file" {
       source      = "aws_key_server.pem.pub"
        destination = "/home/ec2-user/aws_key_server.pem.pub"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.indexer_key.private_key_pem
        }
    }
}

# Wazuh Server EC2 Instance
resource "aws_instance" "wazuh_server_13700" {
    ami           = data.aws_ami.amzn2.id  # "ami-0c1bc246476a5572b"
    instance_type = "t3.medium"
    security_groups = [ "${aws_security_group.security_group_13700.name}"]
    key_name= aws_key_pair.aws_key_server.key_name
    associate_public_ip_address = true

    root_block_device {
        volume_size           = 20
        volume_type           = "gp3"
        delete_on_termination = true
    }
    
    
    tags = {
        Name = "wazuh_server_13700"
    }


    credit_specification {
        cpu_credits = "standard"
    }

    provisioner "file" {
        source      = "configure-server.yml"
        destination = "/home/ec2-user/configure-server.yml"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.server_key.private_key_pem
        }

    }

}


# Wazuh Dashboard EC2 Instance
resource "aws_instance" "wazuh_dashboard_13700" {
    ami           = data.aws_ami.amzn2.id  # "ami-0c1bc246476a5572b"
    instance_type = "t3.large"
    security_groups = [ "${aws_security_group.security_group_13700.name}"]
    key_name= aws_key_pair.aws_key_dashboard.key_name
    associate_public_ip_address = true

    root_block_device {
        volume_size           = 20
        volume_type           = "gp3"
        delete_on_termination = true
    }
    
    
    tags = {
        Name = "wazuh_dashboard_13700"
    }


    credit_specification {
        cpu_credits = "standard"
    }

    provisioner "file" {
        source      = "configure-dashboard.yml"
        destination = "/home/ec2-user/configure-dashboard.yml"

        connection {
            host        = coalesce(self.public_ip, self.private_ip)
            agent       = true
            type        = "ssh"
            user        = "ec2-user"
            private_key = tls_private_key.dashboard_key.private_key_pem
        }
    }

}