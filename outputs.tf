output "streams" {
  value = jsondecode(data.http.stream_source.response_body)
  description = "The Structured output of stream information from the airbyte API"
}
