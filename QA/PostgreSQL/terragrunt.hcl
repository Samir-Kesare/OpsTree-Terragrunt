include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"  

}

inputs = {
    vpc_id              = "vpc-0a744f2efc4febb2a"
    key_name            = "postgreSQLqaTG.pem"
    server_type         = "t2.medium"
    subnet_id           = "subnet-0dc05fffbacb821e8"
    sec_grp_name = "PostgreSQL-QA-TG-sg"
    sec_grp_tags = {
        Name          = "PostgreSQL-TG-sg"
        Enviroment    = "QA"
        Owner         = "Harshit"
    }
    server_name         = "Postgres-QA-TG"
    inbound_ports = [ {
    port = 22 , protocol = "tcp" , security_group_ids = "sg-0ced15d988acdb94b" 
    },
    {
    port = 5432 , protocol = "tcp" , security_group_ids = "sg-0a4ecb0570e13e365"
    },
    {
    port = 22 , protocol = "tcp" , cidr_blocks = "20.0.0.0/28"
    } ]
}
