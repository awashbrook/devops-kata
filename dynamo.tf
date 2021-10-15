
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "DevOps-Kata"
  hash_key     = "COUNTER"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "COUNTER"
    type = "S"
  }

}

resource "aws_iam_role" "dynamodb" {
  name = "database"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "dynamodb.amazonaws.com"
      }
      }
    ]
  })
}

# resource "aws_iam_role_policy_attachment" "dynamo_policy" {
#   role       = aws_iam_role.dynamodb.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
# }

resource "aws_iam_instance_profile" "dynamodb-table-role-instanceprofile" {
  name = "dynamodb-table-role"
  role = aws_iam_role.dynamodb.name
}

resource "aws_iam_role_policy" "dynamodb-table-role-policy" {
  name   = "dynamodb-table-role-policy"
  role   = aws_iam_role.dynamodb.id
  policy = <<EOF
{
    "Version": "2012-10-17",
        "Statement" : [
      {
        "Sid" : "ListAndDescribe",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:List*",
          "dynamodb:DescribeReservedCapacity*",
          "dynamodb:DescribeLimits",
          "dynamodb:DescribeTimeToLive"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "SpecificTable",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:BatchGet*",
          "dynamodb:DescribeStream",
          "dynamodb:DescribeTable",
          "dynamodb:Get*",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:BatchWrite*",
          "dynamodb:CreateTable",
          "dynamodb:Delete*",
          "dynamodb:Update*",
          "dynamodb:PutItem"
        ],
        "Resource" : "arn:aws:dynamodb:*:*:table/DevOps-Kata"
      }
    ]

}
EOF

}
















