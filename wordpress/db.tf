resource "aws_db_subnet_group" "mysql" {
  name = "mysql"
  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private_sub.id,
  ]
}

resource "aws_db_parameter_group" "mysql" {
  name   = "mysql"
  family = "mysql8.0"
}

resource "aws_db_option_group" "mysql" {
  name                 = "mysql"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = 10
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  username               = "root"
  password               = "password"
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  parameter_group_name   = aws_db_parameter_group.mysql.name
  option_group_name      = aws_db_option_group.mysql.name
  skip_final_snapshot    = true
  multi_az               = false
  apply_immediately      = true
}
