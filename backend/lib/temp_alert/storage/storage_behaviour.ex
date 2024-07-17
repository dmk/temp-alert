defmodule TempAlert.StorageBehaviour do
  @moduledoc """
  A behaviour module for defining the storage operations for TempAlert.

  This behaviour specifies the required functions that any storage module must implement
  to be used as a backend for storing, retrieving, and managing alerts in the TempAlert system.

  ## Callbacks

    - `add_alert/1`: Adds an alert to the storage.
    - `get_alert/1`: Retrieves an alert by its ID.
    - `get_all_alerts/0`: Retrieves all alerts from the storage.
    - `delete_alert/1`: Deletes an alert from the storage by its ID.
    - `get_due_alerts/1`: Retrieves alerts that are due based on the provided timestamp.

  ## Example Implementations

  Implementing this behaviour allows you to create different storage backends, such as in-memory,
  database, or Redis-based storage. Here's an example of how you might implement this behaviour
  for an in-memory storage:

  See [AgentStorage Implementation](./lib/temp_alert/storage/agent_storage.ex).

  ## Configuration

  To configure the storage backend, you can set the appropriate module in your application
  environment. For example:

      config :temp_alert, :storage, TempAlert.Storage.AgentStorage

  By implementing this behaviour, you can easily swap out different storage backends without
  changing the core application logic.
  """

  @callback add_alert(alert :: map()) :: any()
  @callback get_alert(id :: any()) :: any()
  @callback get_all_alerts() :: list()
  @callback delete_alert(id :: any()) :: any()
  @callback get_due_alerts(now :: DateTime.t()) :: list()
end
