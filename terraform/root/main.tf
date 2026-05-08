module "eventbridge_bus" {
  source = "../modules/eventbridge-bus"

  application = local.application
  component   = "infra"
  environment = var.environment
  common_tags = local.common_tags
}