include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"  

}

inputs = {
    vpc_id              = "vpc-007fd0dab685edb84"
    key_name            = "OpenVPN.pem"
    server_type         = "t2.micro"
    subnet_id           = "subnet-0bfc1d2a2cc04f2aa"
    sec_grp_name = "OpenVPN-SG-TG"
    sec_grp_tags = {
        Name          = "OpenVPN-SG-TG"
        Enviroment    = "Dev"
        Owner         = "Shantanu"
    }
    server_name         = "OpenVPN-Dev"
    inbound_ports = [ 
    {
    port = 1194 , protocol = "tcp" , cidr_blocks = "0.0.0.0/0"
    },
    {
    port = 22 , protocol = "tcp" , cidr_blocks = "20.0.0.0/26"
    } ]
}
