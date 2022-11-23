resource "aws_lb" "App-alb" {
  name               = "App-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.websgid
  subnets            = var.websubnet
}

resource "aws_lb_target_group" "target-elb" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpcid
}

resource "aws_launch_configuration" "foobar" {
  name_prefix   = "assign"
  image_id      = "ami-0535d910c0c8a6c4a"
  instance_type = "t2.micro"
  security_groups = var.websgid
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "bar" {
  #availability_zones = ["ap-south-1a","ap-south-1b"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  health_check_grace_period = 300
  vpc_zone_identifier = var.websubnet
  launch_configuration = aws_launch_configuration.foobar.name
  health_check_type   = "ELB"
}
resource "aws_autoscaling_attachment" "bar" {
  autoscaling_group_name = aws_autoscaling_group.bar.id
  alb_target_group_arn    = aws_lb_target_group.target-elb.arn
}



resource "aws_lb_listener" "App-alb" {
  load_balancer_arn = aws_lb.App-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-elb.arn
  }
}