resource "aws_db_subnet_group" "mysubnetgroupname" {
  subnet_ids =  var.private_subnetID # DB subnet group

  tags = {
		Name = "DBSubnetGroup"
		Environment = var.environment
        Project = var.project
	    Terraformed = "True"
	}
}

resource "aws_db_instance" "CreateDatabaseFromRDS" {
  allocated_storage    = var.RdsDatabase.allocated_storage
  storage_type         = var.RdsDatabase.storage_type
  engine               = var.RdsDatabase.engine
  engine_version       = var.RdsDatabase.engine_version
  instance_class       = var.RdsDatabase.instance_class
  name                 = var.RdsDatabase.name
  username             = var.RdsDatabase.username
  password             = var.RdsDatabase.password
  parameter_group_name = var.RdsDatabase.parameter_group_name
  skip_final_snapshot = var.RdsDatabase.skip_final_snapshot
  deletion_protection = var.RdsDatabase.deletion_protection
  vpc_security_group_ids = [var.PrivateSecurityGrpID]
  db_subnet_group_name = aws_db_subnet_group.mysubnetgroupname.id
  
  tags = {
		Name = "DBInstanceTags"
		Environment = var.environment
        Project = var.project
	    Terraformed = "True"
	}
}
