resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "web" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.web_subnets_cidr)
  cidr_block              = element(var.web_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-web-sb-0${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_subnet" "app" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.app_subnets_cidr)
  cidr_block              = element(var.app_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-app-sb-0${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

resource "aws_subnet" "db" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.db_subnets_cidr)
  cidr_block              = element(var.db_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.environment}-${element(var.availability_zones, count.index)}-db-sb-0${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_route_table" "web" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-web-rt"
    Environment = var.environment
  }
}

resource "aws_route_table" "app" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-app-rt"
    Environment = var.environment
  }
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-db-rt"
    Environment = var.environment
  }
}

resource "aws_route" "web_igw" {
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.web.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "web" {
  count          = length(var.web_subnets_cidr)
  subnet_id      = element(aws_subnet.web.*.id, count.index)
  route_table_id = aws_route_table.web.id
}

resource "aws_route_table_association" "app" {
  count          = length(var.app_subnets_cidr)
  subnet_id      = element(aws_subnet.app.*.id, count.index)
  route_table_id = aws_route_table.app.id
}

resource "aws_route_table_association" "db" {
  count          = length(var.db_subnets_cidr)
  subnet_id      = element(aws_subnet.db.*.id, count.index)
  route_table_id = aws_route_table.db.id
}

resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = aws_vpc.main.id
  depends_on  = [aws_vpc.main]

  tags = {
    Name        = "${var.environment}-default-sg"
    Environment = var.environment
  }
}
