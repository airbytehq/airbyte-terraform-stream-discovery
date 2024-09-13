
# Get the streams
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

# Set up a connection
resource "airbyte_connection" "postgres_to_bigquery_full_refresh" {
  name           = "Postgres to BigQuery Full Refresh"
  source_id      = airbyte_source_postgres.my_source_postgres.source_id
  destination_id = airbyte_destination_bigquery.my_destination_bigquery.destination_id
  schedule = {
    schedule_type = "manual"
  }
  configurations = {
    # use the steams here
    streams = local.full_refresh_streams
  }
}


# requried setup
resource "airbyte_source_postgres" "my_source_postgres" {
  configuration = {
    database        = "...my_database..."
    host            = "...my_host..."
    jdbc_url_params = "...my_jdbc_url_params..."
    password        = "...my_password..."
    port            = 5432
    replication_method = {
      source_postgres_update_method_detect_changes_with_xmin_system_column = {
        method = "Xmin"
      }
    }
    schemas = [
      "...",
    ]
    source_type = "postgres"
    ssl_mode = {
      source_postgres_ssl_modes_allow = {
        mode = "allow"
      }
    }
    tunnel_method = {
      source_postgres_ssh_tunnel_method_no_tunnel = {
        tunnel_method = "NO_TUNNEL"
      }
    }
    username = "Edwardo.Streich"
  }
  name         = "Roosevelt Cummings"
  secret_id    = "...my_secret_id..."
  workspace_id = "480632b9-954b-46fa-a206-369828553cb1"
}

resource "airbyte_destination_bigquery" "my_destination_bigquery" {
  configuration = {
    big_query_client_buffer_size_mb = 15
    credentials_json                = "...my_credentials_json..."
    dataset_id                      = "...my_dataset_id..."
    dataset_location                = "australia-southeast2"
    destination_type                = "bigquery"
    loading_method = {
      destination_bigquery_loading_method_gcs_staging = {
        credential = {
          destination_bigquery_loading_method_gcs_staging_credential_hmac_key = {
            credential_type    = "HMAC_KEY"
            hmac_key_access_id = "1234567890abcdefghij1234"
            hmac_key_secret    = "1234567890abcdefghij1234567890ABCDEFGHIJ"
          }
        }
        file_buffer_count        = 10
        gcs_bucket_name          = "airbyte_sync"
        gcs_bucket_path          = "data_sync/test"
        keep_files_in_gcs_bucket = "Delete all tmp files from GCS"
        method                   = "GCS Staging"
      }
    }
    project_id              = "...my_project_id..."
    raw_data_dataset        = "...my_raw_data_dataset..."
    transformation_priority = "batch"
  }
  name         = "Edna Pouros"
  workspace_id = "d488e1e9-1e45-40ad-aabd-44269802d502"
}

