data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_event_bus" "this" {

  name = "${var.application}-${var.component}-bus-${var.environment}"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.application}-${var.component}-bus-${var.environment}"

      component = var.component
    }
  )
}

resource "aws_cloudwatch_event_bus_policy" "allow_account_publish" {

  event_bus_name = aws_cloudwatch_event_bus.this.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowAccountPutEvents"
        Effect = "Allow"

        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }

        Action = "events:PutEvents"

        Resource = aws_cloudwatch_event_bus.this.arn
      }
    ]
  })
}