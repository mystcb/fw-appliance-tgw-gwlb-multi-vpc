### Using IP's here as it is a simple test of the GWLB. This would be populated
### using the Autoscaling group attachment for the real work scenario.
###
### Additionally, please read the note about the LB Target Group Tag issue.

# Target group for the GWLB
resource "aws_lb_target_group" "fwa" {
  name        = "Firewall-Appliances-TG"
  target_type = "ip"
  vpc_id      = aws_vpc.egress_vpc.id
  protocol    = "GENEVE"
  port        = 6081

  health_check {
    interval = 30
    port     = 8117
    protocol = "TCP"
  }
  ### NOTE: Error: error creating LB Target Group: ValidationError: You cannot specify tags on creation of a GENEVE target group
  ### https://github.com/hashicorp/terraform-provider-aws/issues/20144
}

# Attach a sample instance 1
# Note that this sample instance should be part of an autoscaling group or other
# such systems, here we have used a static IP for an EC2 instance (just selected)
# a random IP in the subnet range as an example.
resource "aws_lb_target_group_attachment" "fwa_1" {
  target_group_arn = aws_lb_target_group.fwa.arn
  target_id        = "192.168.8.5"
}

# Attach a sample instance 2
# Note that this sample instance should be part of an autoscaling group or other
# such systems, here we have used a static IP for an EC2 instance (just selected)
# a random IP in the subnet range as an example.
resource "aws_lb_target_group_attachment" "fwa_2" {
  target_group_arn = aws_lb_target_group.fwa.arn
  target_id        = "192.168.8.21"
}

###
### Creation of the Gateway Load Balancer and listeners
###

# Create the Gateway Load Balancer
resource "aws_lb" "gwlb" {
  name               = "Firewall-Appliance-GWLB"
  load_balancer_type = "gateway"
  subnets            = aws_subnet.fwa_subnets.*.id
}

# Create the listners
resource "aws_lb_listener" "gwlb" {
  load_balancer_arn = aws_lb.gwlb.id

  default_action {
    target_group_arn = aws_lb_target_group.fwa.id
    type             = "forward"
  }

}