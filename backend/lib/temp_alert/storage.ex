defmodule TempAlert.Storage do
  @moduledoc """
  The `TempAlert.Storage` module provides a unified interface to interact with the storage backend,
  which can be either in-memory using Agent or persistent using Redis.
  """

  @doc """
  Adds an alert to the storage.
  """
  def add_alert(alert), do: storage_backend().add_alert(alert)

  @doc """
  Retrieves an alert by its ID.
  """
  def get_alert(id), do: storage_backend().get_alert(id)

  @doc """
  Retrieves all alerts from the storage.
  """
  def get_all_alerts, do: storage_backend().get_all_alerts()

  @doc """
  Deletes an alert by its ID.
  """
  def delete_alert(id), do: storage_backend().delete_alert(id)

  @doc """
  Retrieves due alerts based on the provided time.
  """
  def get_due_alerts(now), do: storage_backend().get_due_alerts(now)

  defp storage_backend do
    Application.get_env(:temp_alert, :storage)
  end
end
