# Stream Discovery
Presently our terraform provider does not provide access to the streams of a source. 
When configuring a connection between a source and destination, you need the streams and their sync modes.

This module is a wrapper around the [Get Stream Properties Endpoint](https://reference.airbyte.com/reference/liststreams)
and will fetch the streams from the airbyte api and return a list of streams with the following structure

```
{
  propertyFields: list(list(string))
  sourceDefinedCursorField: boolean
  sourceDefinedPrimaryKey: list(string)
  streamName: string
  syncModes: list(string)
}
```
