include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/Auto_Sacling_Module?ref=main"  

}
inputs = {
        security_name = "Dev-Frontend-sg"
        Security_description = "Security group for SalaryAPI ASG in qa environment"
        SG_vpc_id = "vpc-0383f4dc3af051efa"
        inbound_ports = [
             { port = 22, protocol = "tcp",cidr_blocks = "20.0.0.0/28" }, 
             { port = 22, protocol = "tcp", security_group_ids = "sg-0f470a22a92136557" },   
             { port = 3000, protocol = "tcp", security_group_ids = "sg-0b426399b2b19b0ae" },  
        ]
        outbound_ports = [
            { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
        ]
        Sg_tags = {
            Name = "Dev-Frontend-sg"
             Enviroment    = "Dev_Frontend"
            Owner         = "Khushi"                       
        }
        template_name = "Dev-Frontend-template"
        AMI_ID = "ami-0c335502f397b30c6"
        instance_type = "t2.micro"
        instance_keypair = "Dev_Frontend_Key"
        subnet_ID = "subnet-04c0c823118f48202"
        target_group_name = "Dev-Frontend-TG"
        TG_vpc_id = "vpc-0383f4dc3af051efa"
        listener_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:133673781875:listener/app/Dev-ALB/75bc9b1a35dbe964/761653fb399a30be"
        autoscaling_group_name = "Dev-Frontend_ASG"
        subnet_ids = ["subnet-04c0c823118f48202"]
        tag_key = "Name"
        tag_value = "Dev-Frontend_ASG"

}
