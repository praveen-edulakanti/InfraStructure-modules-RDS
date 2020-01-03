/*resource "aws_launch_template" "ASConfTemplate" {
  name_prefix   = var.AutoScalingLaunchTemplate.name
  image_id      = var.AutoScalingLaunchTemplate.ami
  instance_type = var.AutoScalingLaunchTemplate.instance_type
}

resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}*/

resource "aws_launch_configuration" "as_conf" {
  name_prefix   =  var.AutoScalingLaunchconfig.name
  image_id      =  var.AutoScalingLaunchconfig.ami
  instance_type =  var.AutoScalingLaunchconfig.instance_type
  associate_public_ip_address = false
  key_name      =  var.AutoScalingLaunchconfig.key_name
  user_data     =  file(var.AutoScalingLaunchconfig.user_data)
  security_groups = [var.LoadBalSecurityGrpID]
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "as_grp" {
  name                 = var.AutoScalingGrp.name
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = var.AutoScalingGrp.min_Instsize
  max_size             = var.AutoScalingGrp.max_Instsize
  health_check_grace_period = var.AutoScalingGrp.health_check_grace_period
  health_check_type         = var.AutoScalingGrp.health_check_type
  desired_capacity          = var.AutoScalingGrp.desired_capacity
  force_delete              = var.AutoScalingGrp.force_delete
  #placement_group          = aws_placement_group.test.id
  vpc_zone_identifier       = var.private_subnetID

  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      key                 = "Name"
      value               = var.AutoScalingGrp.name
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.environment
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = var.project
      propagate_at_launch = true
    },
     {
      key                 = "Terraformed"
      value               = "True"
      propagate_at_launch = true
    }
  ]

  
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  count = length(var.targetgroup_arn)
  autoscaling_group_name =  aws_autoscaling_group.as_grp.id
  alb_target_group_arn   =  var.targetgroup_arn[count.index]
}