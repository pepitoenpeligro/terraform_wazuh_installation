# resource "aws_key_pair" "aws_key_indexer" {
#     key_name   = "aws_key_indexer"
#     public_key = file("${abspath(path.cwd)}/aws_key_indexer.pem.pub")
# }

# resource "aws_key_pair" "aws_key_server" {
#     key_name   = "aws_key_server"
#     public_key = file("${abspath(path.cwd)}/aws_key_server.pem.pub")
# }

# resource "aws_key_pair" "aws_key_dashboard" {
#     key_name   = "aws_key_dashboard"
#     public_key = file("${abspath(path.cwd)}/aws_key_dashboard.pem.pub")
# }


# indexer_key {indexer_key.pem, mykindexer_key.pem.pub}
resource "tls_private_key" "indexer_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_key_indexer" {
  key_name   = "aws_key_indexer"
  public_key = tls_private_key.indexer_key.public_key_openssh

  provisioner "local-exec" {
    # openssl genrsa -out mykey.pem 1024
    # openssl rsa -in mykey.pem -pubout > mykey.pub
    command = "echo '${tls_private_key.indexer_key.private_key_pem}' > ./aws_key_indexer.pem && openssl rsa -in aws_key_indexer.pem -pubout > aws_key_indexer.pem.pub"
  }
}


# server_key {server_key.pem, mykserver_key.pem.pub}
resource "tls_private_key" "server_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_key_server" {
  key_name   = "aws_key_server"
  public_key = tls_private_key.server_key.public_key_openssh

  provisioner "local-exec" {
    # openssl genrsa -out mykey.pem 1024
    # openssl rsa -in mykey.pem -pubout > mykey.pub
    command = "echo '${tls_private_key.server_key.private_key_pem}' > ./aws_key_server.pem && openssl rsa -in aws_key_server.pem -pubout > aws_key_server.pem.pub"
  }
}


# dashboard_key {dashboard_key.pem, mykdashboard_key.pem.pub}
resource "tls_private_key" "dashboard_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_key_dashboard" {
  key_name   = "aws_key_dashboard"
  public_key = tls_private_key.dashboard_key.public_key_openssh

  provisioner "local-exec" {
    # openssl genrsa -out mykey.pem 1024
    # openssl rsa -in mykey.pem -pubout > mykey.pub
    command = "echo '${tls_private_key.dashboard_key.private_key_pem}' > ./aws_key_dashboard.pem && openssl rsa -in aws_key_dashboard.pem -pubout > aws_key_dashboard.pem.pub"
  }
}