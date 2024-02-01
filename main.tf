terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
      version = ">= 3.4.0"
    }

  }
}

locals {
  authorization_header = (
    var.airbyte_api_token != "" ?
    "Bearer ${var.airbyte_api_token}" :
    "Basic ${base64encode("${var.airbyte_basic_auth_username}:${var.airbyte_basic_auth_password}")}"
    )
}

data "http" "stream_source" {
  url = "${var.airbyte_host_url}/v1/streams?sourceId=${var.source_id}&destinationId=${var.destination_id}&ignoreCache=${var.ignore_cache}"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
    Authorization = local.authorization_header
  }
}
