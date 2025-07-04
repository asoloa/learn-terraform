# IAM role for Lambda execution
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Package the Lambda function code
data "archive_file" "lambda_func_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_func.py"
  output_path = "${path.module}/lambda_func.zip"
}

# Lambda function
resource "aws_lambda_function" "lambda_func" {
  filename         = data.archive_file.lambda_func_zip.output_path
  function_name    = "asoloa_com-views_counter"
  role             = aws_iam_role.iam_role.arn
  handler          = "lambdafunc.handler"
  source_code_hash = data.archive_file.lambda_func_zip.output_base64sha256

  runtime = "python3.13"
  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.visitor-count-table.name
      DYNAMODB_TABLE_PK = "id"
      DYNAMODB_TABLE_ITEM = "view-count"
    }
  }
}