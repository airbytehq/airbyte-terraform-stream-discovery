output "streams" {
  value = jsondecode(data.http.stream_source.response_body)
}
