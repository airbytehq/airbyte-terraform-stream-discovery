variable "airbyte_api_token" {
  type = string
  sensitive = true
  description = "A valid api token for airbyte"
  validation {
    condition = var.airbyte_api_token != "" || (var.airbyte_basic_auth_username != "" && var.airbyte_basic_auth_password != "")
    error_message = "Either an api token or basic auth credentials must be provided"
  }
}

variable "source_id" {
  type = string
  description = "The ID of the source to discover streams from"
}

variable "destination_id" {
  type = string
  description = "The ID of the destination to write streams to"
}

variable "airbyte_host_url" {
  type = string
  description = "URL where airbyte is hosted"
  default = "https://api.airbyte.com"
}

variable airbyte_basic_auth_username {
  type = string
  description = "Username for basic auth"
}

variable airbyte_basic_auth_password {
  type = string
  description = "Password for basic auth"
  sensitive = true
}

variable "ignore_cache" {
  type = bool
  description = "Whether to pull values from the cache or not"
  default = true
}
