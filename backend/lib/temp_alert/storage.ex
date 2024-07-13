defmodule TempAlert.Storage do
  @moduledoc """
  The `TempAlert.Storage` module provides functions to manage alerts stored in the `AlertsAgent`.

  This module serves as an interface to add, retrieve, delete, and filter alerts based on their notification time.
  It abstracts the underlying storage mechanism and provides a simple API for interacting with alerts.

  ## Functions

    - `add_alert/1`: Adds a new alert to the storage.
    - `get_alert/1`: Retrieves an alert by its ID.
    - `get_all_alerts/0`: Retrieves all alerts from the storage.
    - `delete_alert/1`: Deletes an alert by its ID.
    - `get_due_alerts/1`: Retrieves alerts that are due based on the provided time.

  ## Examples

      iex> alert = %TempAlert.Schemas.Alert{id: "1", instance: "example", message: "Test", timestamp: "2024-07-12T00:00:00Z", notify_at: "2024-07-13T00:00:00Z"}
      iex> TempAlert.Storage.add_alert(alert)
      :ok

      iex> TempAlert.Storage.get_alert("1")
      %TempAlert.Schemas.Alert{id: "1", instance: "example", message: "Test", timestamp: "2024-07-12T00:00:00Z", notify_at: "2024-07-13T00:00:00Z"}

      iex> TempAlert.Storage.get_due_alerts(DateTime.utc_now())
      [%TempAlert.Schemas.Alert{id: "1", instance: "example", message: "Test", timestamp: "2024-07-12T00:00:00Z", notify_at: "2024-07-13T00:00:00Z"}]
  """
  alias TempAlert.AlertsAgent

  def add_alert(alert), do: AlertsAgent.add_alert(alert)
  def get_alert(id), do: AlertsAgent.get_alert(id)
  def get_all_alerts, do: AlertsAgent.get_all_alerts()
  def delete_alert(id), do: AlertsAgent.delete_alert(id)

  def get_due_alerts(now) do
    AlertsAgent.get_all_alerts()
    |> Enum.filter(fn alert ->
      {:ok, notify_at, _} = DateTime.from_iso8601(alert.notify_at)
      DateTime.compare(notify_at, now) != :gt
    end)
  end
end
