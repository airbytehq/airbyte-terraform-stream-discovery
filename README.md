# Stream Discovery
Presently our terraform provider does not provide access to the streams of a source.
When configuring a connection between a source and destination, you need the streams and their sync modes.

This module is a wrapper around the [Get Stream Properties Endpoint](https://reference.airbyte.com/reference/liststreams)
and will fetch the streams from the airbyte api and return a list of streams with the following structure

```
{
  propertyFields: list(list(string))
  sourceDefinedCursorField: bool
  sourceDefinedPrimaryKey: list(string)
  streamName: string
  syncModes: list(string)
}
```

You can then use [terraform's expressions](https://developer.hashicorp.com/terraform/language/expressions) to manipulate this into the input required for the [Airbyte Connection configuration.streams](https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs/resources/connection#nestedatt--configurations--streams) object.

Here is an example usage:

```
module "source_postgres_streams" {
  source            = "airbytehq/stream-discovery/airbyte"
  airbyte_api_token = "FOO" # REPLACE
  source_id         = airbyte_source_postgres.my_source_postgres.source_id
  destination_id    = airbyte_destination_bigquery.my_destination_bigquery.destination_id
}

# Convert them to the required structure
locals {
  full_refresh_streams = [for stream in module.source_postgres_streams.streams :
    {
      name      = stream.streamName
      sync_mode = "full_refresh_overwrite"
    }
  ]
}
```
