resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"
}

resource "aws_subnet" "main-1" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.subnet_cidr1}"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
}

resource "aws_subnet" "main-2" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.subnet_cidr2}"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"

}

# resource "aws_db_subnet_group" "default" {
#   name       = "main"
#   subnet_ids = [aws_subnet.databasesub-1.id, aws_subnet.databasesub-2.id]
# }


resource "aws_subnet" "databasesub-1" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.database1_cidr}"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "databasesub-2" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.database2_cidr}"
  availability_zone = "ap-south-1b"
}
resource "aws_security_group" "websg" {
  vpc_id = "${var.vpc_id}"

  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}
resource "aws_route_table" "route" {
    vpc_id = "${var.vpc_id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.gatewayid
    }

    tags = {
        Name = "Route to internet"
    }
}

# Associating Route Table
resource "aws_route_table_association" "rt1" {
    subnet_id = "${aws_subnet.main-1.id}"
    route_table_id = "${aws_route_table.route.id}"
}

# Associating Route Table
resource "aws_route_table_association" "rt2" {
    subnet_id = "${aws_subnet.main-2.id}"
    route_table_id = "${aws_route_table.route.id}"
}




output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "subnet_cidr1" {
  value = "${aws_subnet.main-1.id}"
}

output "subnet_cidr2" {
  value = "${aws_subnet.main-2.id}"
}


output "database1_id" {
  value = "${aws_subnet.databasesub-1.id}"
}

output "database2_id" {
  value = "${aws_subnet.databasesub-2.id}"
}
