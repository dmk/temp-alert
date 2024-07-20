defmodule TempAlert.Storage.AgentStorage do
  @moduledoc """
  An in-memory storage module for TempAlert that uses Elixir's Agent for state management.

  This module implements the `TempAlert.StorageBehaviour` and provides in-memory
  storage for alerts. It uses Elixir's Agent to manage the state of alerts in the system.

  ## Functions

    - `start_link/1`: Starts the Agent process.
    - `add_alert/1`: Adds an alert to the in-memory storage.
    - `get_alert/1`: Retrieves a specific alert by its ID.
    - `get_all_alerts/0`: Retrieves all alerts from the in-memory storage.
    - `delete_alert/1`: Deletes an alert from the in-memory storage by its ID.
    - `get_due_alerts/1`: Retrieves alerts that are due based on the provided timestamp.

  ## Example

      iex> TempAlert.Storage.AgentStorage.start_link(nil)
      {:ok, #PID<0.123.0>}

      iex> TempAlert.Storage.AgentStorage.add_alert(%TempAlert.Schemas.Alert{id: "1", instance: "example", message: "test alert", timestamp: DateTime.utc_now(), notify_at: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()})
      :ok

      iex> TempAlert.Storage.AgentStorage.get_alert("1")
      %TempAlert.Schemas.Alert{id: "1", instance: "example", message: "test alert", timestamp: DateTime.utc_now(), notify_at: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()}

      iex> TempAlert.Storage.AgentStorage.get_all_alerts()
      [%TempAlert.Schemas.Alert{id: "1", instance: "example", message: "test alert", timestamp: DateTime.utc_now(), notify_at: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()}]

      iex> TempAlert.Storage.AgentStorage.delete_alert("1")
      :ok

      iex> TempAlert.Storage.AgentStorage.get_due_alerts(DateTime.utc_now())
      [%TempAlert.Schemas.Alert{id: "1", instance: "example", message: "test alert", timestamp: DateTime.utc_now(), notify_at: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601()}]

  ## Configuration

  This module does not require any special configuration and works out-of-the-box with Elixir's Agent.
  It can be used as a drop-in replacement for other storage backends that implement the `TempAlert.StorageBehaviour`.

  To use this storage backend, set the appropriate module in your application environment. For example:

      config :temp_alert, :storage, TempAlert.Storage.AgentStorage
  """

  @behaviour TempAlert.StorageBehaviour

  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @impl true
  def add_alert(alert) do
    Agent.update(__MODULE__, &Map.put(&1, alert.id, alert))
  end

  @impl true
  def get_alert(id) do
    Agent.get(__MODULE__, &Map.get(&1, id))
  end

  @impl true
  def get_all_alerts do
    Agent.get(__MODULE__, &Map.values(&1))
  end

  @impl true
  def delete_alert(id) do
    Agent.update(__MODULE__, &Map.delete(&1, id))
  end

  @impl true
  def get_due_alerts(now) do
    Agent.get(__MODULE__, fn alerts ->
      alerts
      |> Map.values()
      |> Enum.filter(fn alert -> DateTime.before?(alert.notify_at, now) end)
    end)
  end
end
