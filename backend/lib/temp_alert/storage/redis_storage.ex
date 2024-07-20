defmodule TempAlert.Storage.RedisStorage do
  @moduledoc """
  A storage module for TempAlert that uses Redis as the backend.

  This module implements the `TempAlert.StorageBehaviour` and uses `Redix`
  to interact with a Redis database for storing and retrieving alerts.

  ## Configuration

  The Redis connection details are expected to be provided in the application
  environment under the `:temp_alert, :redis` key. For example:

      config :temp_alert, :redis,
        host: "localhost",
        port: 6379,
        password: "yourpassword"

  ## Functions

    - `start_link/1`: Starts the Redix connection.
    - `add_alert/1`: Adds an alert to the Redis storage.
    - `get_alert/1`: Retrieves a specific alert by its ID.
    - `get_all_alerts/0`: Retrieves all alerts from the Redis storage.
    - `delete_alert/1`: Deletes an alert from the Redis storage by its ID.
    - `get_due_alerts/1`: Retrieves alerts that are due based on the provided timestamp.

  ## Examples

      iex> TempAlert.Storage.RedisStorage.add_alert(%TempAlert.Schemas.Alert{id: "1", instance: "example", message: "test alert", timestamp: DateTime.utc_now(), notify_at: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()})
      :ok

      iex> TempAlert.Storage.RedisStorage.get_alert("1")
      %TempAlert.Schemas.Alert{id: "1", instance: "example", message: "test alert", timestamp: DateTime.utc_now(), notify_at: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()}

      iex> TempAlert.Storage.RedisStorage.get_all_alerts()
      [%TempAlert.Schemas.Alert{id: "1", instance: "example", message: "test alert", timestamp: DateTime.utc_now(), notify_at: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()}]

      iex> TempAlert.Storage.RedisStorage.delete_alert("1")
      :ok

      iex> TempAlert.Storage.RedisStorage.get_due_alerts(DateTime.utc_now())
      [%TempAlert.Schemas.Alert{id: "1", instance: "example", message: "test alert", timestamp: DateTime.utc_now(), notify_at: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()}]

  """
  @behaviour TempAlert.StorageBehaviour

  use GenServer

  @redis_key "alerts"

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  def start_link(_) do
    redix_config = Application.get_env(:temp_alert, :redis)

    Redix.start_link(
      host: redix_config[:host],
      port: redix_config[:port],
      password: redix_config[:password],
      name: __MODULE__
    )
  end

  @impl true
  def add_alert(alert) do
    Redix.command!(__MODULE__, ["HSET", @redis_key, alert.id, :erlang.term_to_binary(alert)])
  end

  @impl true
  def get_alert(id) do
    case Redix.command!(__MODULE__, ["HGET", @redis_key, id]) do
      nil -> nil
      alert_json -> :erlang.binary_to_term(alert_json)
    end
  end

  @impl true
  def get_all_alerts do
    Redix.command!(__MODULE__, ["HGETALL", @redis_key])
    |> Enum.chunk_every(2)
    |> Enum.map(fn [_, alert_json] ->
      :erlang.binary_to_term(alert_json)
    end)
  end

  @impl true
  def delete_alert(id) do
    Redix.command!(__MODULE__, ["HDEL", @redis_key, id])
  end

  @impl true
  def get_due_alerts(now) do
    get_all_alerts()
    |> Enum.filter(fn alert -> DateTime.before?(alert.notify_at, now) end)
  end
end
