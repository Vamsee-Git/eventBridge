resource "aws_sqs_queue" "gold" {
  name = "sqs-gold"
}

resource "aws_sqs_queue" "silver" {
  name = "sqs-silver"
}

resource "aws_cloudwatch_event_bus" "event_bus" {
  name = var.event_bus_name
}

#Event rule for gold
resource "aws_cloudwatch_event_rule" "rule1" {
  name = "Rule1"
  event_bus_name = aws_cloudwatch_event_bus.event_bus.name
  event_pattern = jsonencode({
    "source": ["lambdaFunction_SQS"],
    "detail-type": ["client-details"],
    "detail": {
      "client-type": ["gold"]
    }
  })
}

resource "aws_cloudwatch_event_target" "this1" {
  rule      = aws_cloudwatch_event_rule.rule1.name
  arn       = aws_sqs_queue.gold.arn
  event_bus_name = aws_cloudwatch_event_bus.event_bus.name
  depends_on = [aws_cloudwatch_event_rule.rule1]
}


#Event rule for silver
resource "aws_cloudwatch_event_rule" "rule2" {
  name        = "Rule2"
  event_bus_name = aws_cloudwatch_event_bus.event_bus.name
  event_pattern = jsonencode({
    "source": ["lambdaFunction_SQS"],
    "detail-type": ["client-details"],
    "detail": {
      "client-type": ["silver"]
    }
  })
}

resource "aws_cloudwatch_event_target" "this2" {

  rule      = aws_cloudwatch_event_rule.rule2.name
  arn       = aws_sqs_queue.silver.arn
  event_bus_name = aws_cloudwatch_event_bus.event_bus.name
  depends_on = [aws_cloudwatch_event_rule.rule2]
}


output "event_bus_arn" {
  value = aws_cloudwatch_event_bus.event_bus.arn
}
