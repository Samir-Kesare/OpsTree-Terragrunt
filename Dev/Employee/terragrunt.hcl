include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"  

}
inputs = {
        security_name = "dev-employee-sg"
        Security_description = "Security group for EmployeeAPI ASG in dev environment"
        SG_vpc_id = "vpc-00e048db5cbda61fa"
        inbound_ports = [
             { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, 
             { port = 22, protocol = "tcp", security_group_ids = "sg-04ed29afeac1f65e1" },   
             { port = 8080, protocol = "tcp", security_group_ids = "sg-04ed29afeac1f65e1" },  
        ]
        outbound_ports = [
            { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
        ]
        Sg_tags = {
            Name = "dev-employee-sg"
             Enviroment    = "Dev"
            Owner         = "Aakash"                       
        }
        template_name = "dev-employee-launch-template"
        AMI_ID = "ami-003598db5bd1895ae"
        instance_type = "t2.micro"
        instance_keypair = "employeeKey"
        subnet_ID = "subnet-01205dcefa16ba8e3"
        target_group_name = "dev-employee-target-group"
        TG_vpc_id = "vpc-00e048db5cbda61fa"
        listener_arn = "arn:aws:elasticloadbalancing:us-east-1:630493305452:listener/app/dev-alb/f19a9ab198b4e6f6/41d4001b10d4b299"
        autoscaling_group_name = "dev-employee-asg"
        subnet_ids = ["subnet-01205dcefa16ba8e3"]
        tag_key = "Name"
        tag_value = "dev-employee-asg"

}
