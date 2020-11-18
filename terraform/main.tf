provider "apigee" {
  org          = var.apigee_organization
  access_token = var.apigee_token
}

terraform {
  backend "azurerm" {}

  required_providers {
    apigee = "~> 0.0"
    archive = "~> 1.3"
  }
}


module "example-template" {
  source                   = "github.com/NHSDigital/api-platform-service-module"
  name                     = "example-template"
  path                     = "example-template"
  apigee_environment       = var.apigee_environment
  proxy_type               = (var.force_sandbox || length(regexall("sandbox", var.apigee_environment)) > 0) ? "sandbox" : "live"
  namespace                = var.namespace
  make_api_product         = !(length(regexall("sandbox", var.apigee_environment)) > 0)
  api_product_display_name = length(var.namespace) > 0 ? "example-template${var.namespace}" : "example-template-service-api"
  api_product_description  = "{{ config.meta.product_description}}"
}
