region      = "ap-south-1"
environment = "QA"
project     = "DemoProject"
vpc = {
  name       = "QA_VPC"
  cidr_block = "10.100.0.0/16"
}
#Internet Gateway
igw_name = "IGW"

#Elastic IP Address
EIPs = [
  {
    name = "EIP1a"
  },
  {
    name = "EIP1b"
  }
]

#NAT Gateway
NATGateways = [
  {
    name = "NATGateway1a"
  },
  {
    name = "NATGateway1b"
  }
]

public_subnets = [
  {
    name              = "PublicSubnet1a"
    cidr_block        = "10.100.1.0/24"
    availability_zone = "ap-south-1a"
    #map_public_ip_on_launch = true
  },
  {
    name              = "PublicSubnet1b"
    cidr_block        = "10.100.2.0/24"
    availability_zone = "ap-south-1b"
    #map_public_ip_on_launch = true
  }
]

private_subnets = [
  {
    name                    = "PrivateSubnet1a"
    cidr_block              = "10.100.3.0/24"
    availability_zone       = "ap-south-1a"
    map_public_ip_on_launch = false
  },
  {
    name                    = "PrivateSubnet1b"
    cidr_block              = "10.100.4.0/24"
    availability_zone       = "ap-south-1b"
    map_public_ip_on_launch = false
  }
]

private_subnet_route_tables = [
  {
    name = "PrivateSubnetRT1"
  },
  {
    name = "PrivateSubnetRT2"
  }
]

public_subnet_route_tables = [
  {
    name = "PublicRT"
  }
]

PublicSecurityGrp_egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

PrivateSecurityGrp_egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]


PublicInstances = [
  {
    name                        = "PublicInstance1a"
    ami                         = "ami-0123b531fc646552f" #Ubuntu Server 18.04 LTS (HVM)
    availability_zone           = "ap-south-1a"
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    associate_public_ip_address = true
    user_data                   = "./user-data/user-data-pub1.sh"

  },
  {
    name                        = "PublicInstance1b"
    ami                         = "ami-0123b531fc646552f" #Ubuntu Server 18.04 LTS (HVM)
    availability_zone           = "ap-south-1b"
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    associate_public_ip_address = true
    user_data                   = "./user-data/user-data-pub2.sh"
  }
]

PrivateInstances = [
  {

    name                        = "PrivateInstance1a"
    ami                         = "ami-0123b531fc646552f" #Ubuntu Server 18.04 LTS (HVM)
    availability_zone           = "ap-south-1a"
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    associate_public_ip_address = false
    user_data                   = "./user-data/user-data-prv1.sh"

  },
  {
    name                        = "PrivateInstance1b"
    ami                         = "ami-0123b531fc646552f" #Ubuntu Server 18.04 LTS (HVM)
    availability_zone           = "ap-south-1b"
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    associate_public_ip_address = false
    user_data                   = "./user-data/user-data-prv2.sh"
  }
]

TargetGroupNames = [
  {
    name = "User-Service"
  },
  {
    name = "Dashboard-Service"
  }
]

AlbForwardRules = [
	{
		  name = "user"
		  priority  = 90
		  type = "forward"
		  field = "path-pattern"
		  values = "/user*"
	},
	{
		  name = "dashboard"
		  priority  = 100
		  type = "forward"
		  field = "path-pattern"
		  values = "/dashboard*"
	}
]

Route53zone_id   = "Z24SDMK7FWJ00J"

DomainAliases = [
  {
    DomainName = "edulakanti.info"
  },
  {
    DomainName = "www.edulakanti.info"
  }
]

AutoScalingLaunchconfig = {
    name                        = "ASConfigTemplate"
    ami                         = "ami-0123b531fc646552f" #Ubuntu Server 18.04 LTS (HVM)
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    user_data                   = "./user-data/user-data-prv1.sh"

    #availability_zone           = "ap-south-1a"
    #associate_public_ip_address = true
  }

AutoScalingGrp = {
  name            = "AutoScalingGroup"
  min_Instsize    = 2
  max_Instsize    = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
}

dbDetails = {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydemodb"
  username             = "testusr"
  password             = "testpwd"
  parameter_group_name = "default.mysql5.7"
 }