defmodule TempAlert.AlertsAgent do
  @moduledoc """
  The `TempAlert.AlertsAgent` module provides a simple in-memory store for alerts using the `Agent` module.

  This module abstracts the underlying storage mechanism and provides functions to add, retrieve, delete, and list alerts. It maintains the alerts in a map where the keys are alert IDs.

  ## Functions

    - `start_link/1`: Starts the agent with an initial empty state.
    - `add_alert/1`: Adds an alert to the in-memory store.
    - `get_alert/1`: Retrieves an alert by its ID.
    - `get_all_alerts/0`: Retrieves all alerts from the store.
    - `delete_alert/1`: Deletes an alert by its ID.

  ## Examples

      iex> alert = %TempAlert.Schemas.Alert{id: "1", instance: "example", message: "Test", timestamp: "2024-07-12T00:00:00Z", notify_at: "2024-07-13T00:00:00Z"}
      iex> TempAlert.AlertsAgent.start_link([])
      iex> TempAlert.AlertsAgent.add_alert(alert)
      :ok

      iex> TempAlert.AlertsAgent.get_alert("1")
      %TempAlert.Schemas.Alert{id: "1", instance: "example", message: "Test", timestamp: "2024-07-12T00:00:00Z", notify_at: "2024-07-13T00:00:00Z"}

      iex> TempAlert.AlertsAgent.get_all_alerts()
      [%TempAlert.Schemas.Alert{id: "1", instance: "example", message: "Test", timestamp: "2024-07-12T00:00:00Z", notify_at: "2024-07-13T00:00:00Z"}]

      iex> TempAlert.AlertsAgent.delete_alert("1")
      :ok

      iex> TempAlert.AlertsAgent.get_all_alerts()
      []
  """

  use Agent

  @doc """
  Starts the agent with an initial empty state.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc """
  Adds an alert to the in-memory store.
  """
  def add_alert(alert) do
    Agent.update(__MODULE__, &Map.put(&1, alert.id, alert))
  end

  @doc """
  Retrieves an alert by its ID.
  """
  def get_alert(id) do
    Agent.get(__MODULE__, &Map.get(&1, id))
  end

  @doc """
  Retrieves all alerts from the store.
  """
  def get_all_alerts do
    Agent.get(__MODULE__, &Map.values(&1))
  end

  @doc """
  Deletes an alert by its ID.
  """
  def delete_alert(id) do
    Agent.update(__MODULE__, &Map.delete(&1, id))
  end
end
