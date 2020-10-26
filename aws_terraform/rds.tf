## DB Subent Group

resource "aws_db_subnet_group" "dac_db_subnet_group" {
  name       = "dac_db_subnet_group"
  subnet_ids = [aws_subnet.dac_db_subnet_1.id, aws_subnet.dac_db_subnet_2.id]

  tags = {
    Name = "dac_db_subnet_group"
  }
}

## DB instance

resource "aws_db_instance" "dac_db" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  name                    = "mydb"
  identifier              = "dacdb"
  username                = "<db_user>"
  password                = "<db_pass>"
  parameter_group_name    = "default.mysql8.0"
  db_subnet_group_name    = aws_db_subnet_group.dac_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.dac_db_sg.id]
  skip_final_snapshot     = "true"
}
