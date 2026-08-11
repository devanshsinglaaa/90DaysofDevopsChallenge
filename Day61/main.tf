/*
block parameters{

arguements

}

# Hashicorp configuration Language

block:
- resource
- output
- variable
- data
- terraform

parameters:
- resource name
- resource type

arguements:
- configurations
*/



resource aws_s3_bucket my_s3_bucket {

bucket = "udaan-batch-11-demo-bucket-terraform"

}

variable state_table_name {

  type = string
  default = "Terraform-Dynomo-DB-table"

}

resource "aws_dynamodb_table" "my-state-table" {
  name           = var.state_table_name
  billing_mode   = "PROVISIONED"
  hash_key       = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }

  tags = {
    Name = var.state_table_name
  }
}