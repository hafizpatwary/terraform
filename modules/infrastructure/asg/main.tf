#launch configuration
#asg template
#asg policy
#asg policy cloud watch alarm for up and down


data "aws_ami" "ubuntu" {
  	most_recent = true

  	filter {
    	name   = "name"
    	values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  	}

  	filter {
    	name   = "virtualization-type"
    	values = ["hvm"]
  	}

  	owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
  	name 			= join("-", ["launch_config", var.region, var.environment])
  	image_id     	= data.aws_ami.ubuntu.id
  	instance_type	= var.instance-type
  	key_name  	    = var.pem-key
  	#vpc_id 			= var.vpc_id
  	#subnet_id		= var.subnet_id
  	security_groups = [var.vpc_security_group_ids]
  	associate_public_ip_address = true

  	lifecycle {
    	create_before_destroy = true
  	}

}

resource "aws_autoscaling_group" "asg" {
	name                 	= join("-", [var.region, var.environment, "asg"])
	launch_configuration 	= aws_launch_configuration.as_conf.name
	max_size 				= 3
	min_size				= 0
	desired_capacity        = 1
	force_delete			= true
	vpc_zone_identifier		= [var.public_subnet_id]
}

resource "aws_autoscaling_schedule" "start" {
	scheduled_action_name 	= join("-", ["business-hours-", var.region, var.environment])
	autoscaling_group_name  = aws_autoscaling_group.asg.name
	max_size 				= 3
	min_size				= 0
	desired_capacity		= 2
	recurrence				= var.start_date
}

resource "aws_autoscaling_schedule" "stop" {
	scheduled_action_name 	= join("-", ["business-hours-", var.region, var.environment])
	autoscaling_group_name  = aws_autoscaling_group.asg.name
	max_size 				= 3
	min_size				= 0
	desired_capacity		= 0
	recurrence				= var.stop_date
}



########################### CPU Utilization (Future reference)####################################
/*
resource "aws_autoscaling_policy" "policy-up" {
  name                   = join("-", [var.region, var.environment, "policy-up"])
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 100
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type = "SimpleScaling"

  lifecycle {
		create_before_destroy = true
	}
}

resource "aws_cloudwatch_metric_alarm" "alarm-up" {
	alarm_name = "alarm-up"
	comparison_operator = "GreaterThanOrEqualToThreshold"
	evaluation_periods = "2"
	metric_name = "CPUUtilization"
	namespace = "AWS/EC2"
	period = "60"
	statistic = "Average"
	threshold = "70"

	dimensions = {
		"AutoScalingGroupName" = aws_autoscaling_group.asg.name
	}
	
	actions_enabled = true

	alarm_actions = [aws_autoscaling_policy.policy-up.arn]
}

resource "aws_autoscaling_policy" "policy-down" {
	name = "policy-down"
	autoscaling_group_name =  aws_autoscaling_group.asg.name
	adjustment_type = "ChangeInCapacity"
	scaling_adjustment = -1
	cooldown = "100"
	policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "alarm-down" {
	alarm_name = "alarm-down"
	comparison_operator = "LessThanOrEqualToThreshold"
	evaluation_periods = "2"
	metric_name = "CPUUtilization"
	namespace = "AWS/EC2"
	period = "60"
	statistic = "Average"
	threshold = "40"

	dimensions = {
		"AutoScalingGroupName" = aws_autoscaling_group.scale1.name
	}

	actions_enabled = true
	alarm_actions = [aws_autoscaling_policy.policy-down.arn]
}
*/