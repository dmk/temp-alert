defmodule TempAlert.Storage do
  @moduledoc """
  The `TempAlert.Storage` module provides a unified interface to interact with the storage backend,
  which can be either in-memory using Agent or persistent using Redis.
  """

  # @storage Application.compile_env(:temp_alert, :storage, TempAlert.Storage.AgentStorage)

  # IO.inspect(@storage, label: "Storage Backend")  # Debugging line

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
  def get_all_alerts(_), do: storage_backend().get_all_alerts(nil)

  @doc """
  Deletes an alert by its ID.
  """
  def delete_alert(id), do: storage_backend().delete_alert(id)

  @doc """
  Retrieves due alerts based on the provided time.
  """
  def get_due_alerts(now), do: storage_backend().get_due_alerts(now)

  defp storage_backend do
    case System.get_env("TA_STORAGE_BACKEND") do
      "redis" -> TempAlert.Storage.RedisStorage
      _ -> TempAlert.Storage.AgentStorage
    end
  end
end
