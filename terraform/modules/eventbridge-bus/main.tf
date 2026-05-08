resource "aws_cloudwatch_event_bus" "this" {
  name = "${var.application}-${var.component}-bus-${var.environment}"

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.application}-${var.component}-bus-${var.environment}"
      component = var.component
    }
  )
}