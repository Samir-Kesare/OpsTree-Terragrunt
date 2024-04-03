include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git::git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"  

}
inputs = {
    #---------------------------------Security Group ----------------------------------#

Dev_Salary_security_name                       = "Dev-Salary-sg"
Dev_Salary_security_description                = "Security group for Dev-Salary-API"
Dev_Salary_SG_vpc_id                           = "vpc-0052da4c6dfa064a7"    #Dev_Salary-VPC-ID
Dev_Salary_inbound_ports                       = [
  { port                                = 22, protocol = "tcp", cidr_blocks = "20.0.0.0/28" },                     # Management VPC Cidr Block
  { port                                = 22, protocol = "tcp", security_group_ids = "sg-0d89131e48e3b701b" },     #  Dev-Salary-lb-sg ID
  { port                                = 8080, protocol = "tcp", security_group_ids = "sg-0e5092adff377d459" },   # OpenVPN-SG
]
Dev_Salary_outbound_ports                      = [
  { port                                = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }
]
Dev_Salary_Sg_tags                             = {
  Name                                  = "Dev-Salary-sg"
  Enviroment                            = "Dev_Salary"
  Owner                                 = "Salary"
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------Launch Template ----------------------------------#

Dev_Salary_private_key_algorithm               = "RSA"
Dev_Salary_private_key_rsa_bits                = 4096
Dev_Salary_template_name                       = "Dev-Salary-template"
Dev_Salary_template_description                = "Template for Dev-Salary"
Dev_Salary_AMI_ID                              = "ami-00c42911070b51f89"
Dev_Salary_instance_type                       = "t2.micro"
Dev_Salary_instance_keypair                    = "Dev_Salary_Key"
Dev_Salary_subnet_ID                           = "subnet-0fc0d7bdc452d8f92"
Dev_Salary_user_data_script_path               = "./script.sh"

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

Dev_Salary_target_group_name                   = "Dev-Salary-TG"
Dev_Salary_target_group_port                   = 8080
Dev_Salary_target_group_protocol               = "HTTP"
Dev_Salary_TG_vpc_id                           = "vpc-0052da4c6dfa064a7"   #Dev_Salary-VPC-ID
Dev_Salary_health_check_path                   = "/health"
Dev_Salary_health_check_port                   = "traffic-port"
Dev_Salary_health_check_interval               = 30
Dev_Salary_health_check_timeout                = 5
Dev_Salary_health_check_healthy_threshold      = 2
Dev_Salary_health_check_unhealthy_threshold    = 2

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#------------------------------- Listener rule of ALB -----------------------------#

Dev_Salary_listener_arn                          = "arn:aws:elasticloadbalancing:us-east-1:533267087752:listener/app/alb/e5158b76ab1ed034/d229979edeaad51d"
Dev_Salary_path_pattern                          = "/api/v1/salary/*"
Dev_Salary_action_type                           = "forward"
Dev_Salary_priority                              = 100

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------Configure Auto Scaling group ---------------------------#

Dev_Salary_autoscaling_group_name              = "Dev-Salary_ASG"
Dev_Salary_ASG_vserion                         = "$Latest"
Dev_Salary_min_size                            = 1
Dev_Salary_max_size                            = 2
Dev_Salary_desired_capacity                    = 1
Dev_Salary_subnet_ids                          = ["vpc-0052da4c6dfa064a7"]   #Dev-Salary Pvt ID
Dev_Salary_tag_key                             = "Name"
Dev_Salary_tag_value                           = "Dev-Salary_ASG"
Dev_Salary_propagate_at_launch                 = true

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#---------------------------- Auto Scaling Policies -------------------------------#

Dev_Salary_scaling_policy_name                 = "target-tracking-policy"
Dev_Salary_policy_type                         = "TargetTrackingScaling"
Dev_Salary_predefined_metric_type              = "ASGAverageCPUUtilization"
Dev_Salary_target_value                        = 50.0

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#




}
