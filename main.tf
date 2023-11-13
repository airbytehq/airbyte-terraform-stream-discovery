terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
      version = ">= 3.4.0"
    }

  }
}

data "http" "stream_source" {
  url = "${var.airbyte_host_url}/v1/streams?sourceId=${var.source_id}&destinationId=${var.destination_id}&ignoreCache=true"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
    Authorization = "Bearer ${var.airbyte_api_token}"
  }
}
