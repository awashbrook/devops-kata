
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "DevOps-Kata"
  hash_key     = "COUNTER"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "COUNTER"
    type = "S"
  }

}
