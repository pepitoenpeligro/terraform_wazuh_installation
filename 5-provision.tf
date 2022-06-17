

# Provisioning Wazuh Indexer Node
# This node will be configured completly before Wazuh Server and Wazuh Dashboard
resource "null_resource" "configure_indexer"{

  depends_on = [
    aws_instance.wazuh_indexer_13700
  ]
  

  provisioner "remote-exec" {

      inline = [
          "echo ${aws_instance.wazuh_indexer_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/indexer_ip.txt",
          "echo ${aws_instance.wazuh_server_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/server_ip.txt",
          "echo ${aws_instance.wazuh_dashboard_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/dashboard_ip.txt",
          "sudo yum update -y",
          "sudo amazon-linux-extras install ansible2 -y",
          "sudo ansible-playbook /home/ec2-user/configure-indexer.yml",
          "sudo yum remove ansible2 -y"
      ]


      connection {
          host        = coalesce(aws_instance.wazuh_indexer_13700.public_ip, aws_instance.wazuh_indexer_13700.private_ip)
          agent       = true
          type        = "ssh"
          user        = "ec2-user"
          private_key = tls_private_key.indexer_key.private_key_pem
          
          
      }

      
    }
}



resource "null_resource" "configure_server"{

  depends_on = [
    aws_instance.wazuh_indexer_13700,
    null_resource.configure_indexer
  ]
  

  provisioner "remote-exec" {

      inline = [
          "echo ${aws_instance.wazuh_indexer_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/indexer_ip.txt",
          "echo ${aws_instance.wazuh_server_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/server_ip.txt",
          "echo ${aws_instance.wazuh_dashboard_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/dashboard_ip.txt",
          "sudo yum update -y",
          "sudo amazon-linux-extras install ansible2 -y",
          "sudo ansible-playbook /home/ec2-user/configure-server.yml",
          "sudo yum remove ansible2 -y"
      ]


      connection {
          host        = coalesce(aws_instance.wazuh_server_13700.public_ip, aws_instance.wazuh_server_13700.private_ip)
          agent       = true
          type        = "ssh"
          user        = "ec2-user"
          private_key = tls_private_key.server_key.private_key_pem
      }
    }
}



resource "null_resource" "configure_dashboard"{

  depends_on = [
    aws_instance.wazuh_indexer_13700,
    null_resource.configure_indexer
  ]
  

  provisioner "remote-exec" {

      inline = [
          "echo ${aws_instance.wazuh_indexer_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/indexer_ip.txt",
          "echo ${aws_instance.wazuh_server_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/server_ip.txt",
          "echo ${aws_instance.wazuh_dashboard_13700.private_ip} | sed 's/^ *//;s/ *$//' | sed 's/ //g' >> /home/ec2-user/dashboard_ip.txt",
          "sudo yum update -y",
          "sudo amazon-linux-extras install ansible2 -y",
          "sudo ansible-playbook /home/ec2-user/configure-dashboard.yml",
          "sudo yum remove ansible2 -y"
      ]


      connection {
          host        = coalesce(aws_instance.wazuh_dashboard_13700.public_ip, aws_instance.wazuh_dashboard_13700.private_ip)
          agent       = true
          type        = "ssh"
          user        = "ec2-user"
          private_key = tls_private_key.dashboard_key.private_key_pem
      }
    }
}
