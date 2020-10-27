## EC2 INSTANCES

resource "aws_instance" "dac_app" {
  count                         = 3
  ami                           = "ami-02898a1921d38a50b"
  instance_type                 = "t2.micro"
  key_name                      = "<KEY_name>"
  vpc_security_group_ids        = [aws_security_group.dac_app_sg.id]
  subnet_id                     = aws_subnet.dac_app_subnet.id
  associate_public_ip_address   = "true"

  tags = {
    Name = "dac_app_${count.index}"
  }
}

## NLB

resource "aws_lb" "dac_app_lb" {
  name               = "dac-app-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = aws_subnet.dac_app_subnet.*.id

  tags = {
    Environment = "dev"
  }
}

## LB Target Group

resource "aws_lb_target_group" "dac_app_tgp" {
  name     = "dac-app-tgp"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.dac_app_vpc.id
}

## LB Targets Registration

resource "aws_lb_target_group_attachment" "dac_app_tgpa" {
  count            = length(aws_instance.dac_app)
  target_group_arn = aws_lb_target_group.dac_app_tgp.arn
  target_id        = aws_instance.dac_app[count.index].id
  port             = 80
}

## LB Listener

resource "aws_lb_listener" "dac_app_lb_listener" {
  load_balancer_arn = aws_lb.dac_app_lb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dac_app_tgp.arn
  }
}
