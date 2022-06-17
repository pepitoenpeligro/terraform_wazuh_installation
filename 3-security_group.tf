resource "aws_security_group" "security_group_13700"{
    name="security_group_13700"
}

# https://documentation.wazuh.com/current/getting-started/architecture.html?highlight=ports#required-ports
variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "ssh"
        },
        {
          from_port   = 1516
          to_port     = 1516
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "test"
        },
        {
          from_port   = 1515
          to_port     = 1515
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "wazuh-agent-1515"
        },
        {
          from_port   = 1514
          to_port     = 1514
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "wazuh-agent-1514"
        },
        {
          from_port   = 9200
          to_port     = 9200
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "elasticapi"
        },
                {
          from_port   = 9300
          to_port     = 9400
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "elasticnodes"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "ssl"
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "ssl"
        },
        {
          from_port   = 55000
          to_port     = 55000
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "ssl"
        },
        {
          from_port = -1
          to_port = -1
          cidr_block  = "0.0.0.0/0"
          protocol = "icmp"
          description = "icmp ping"
        }
    ]
}


resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)
  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.security_group_13700.id
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.security_group_13700.id
}


