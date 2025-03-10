resource "aws_lambda_function" "this" {
  function_name = var.lambda_function_name
  runtime       = var.lambda_runtime
  handler       = "function1.lambda_handler"
  role          = aws_iam_role.lambda_exec.arn

  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  filename         = "lambda_function_payload.zip"
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_exec" {
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = "events:PutEvents",
        Effect = "Allow",
        Resource = var.event_bus_arn
      }
    ]
  })
}

output "lambda_function_arn" {
  value = aws_lambda_function.this.arn
}

output "invoke_arn" {
  value = aws_lambda_function.this.invoke_arn
}

output "function_name" {
  value = aws_lambda_function.this.function_name
}