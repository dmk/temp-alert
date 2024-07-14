# lib/temp_alert/storage.ex
defmodule TempAlert.Storage do
  @moduledoc """
  The `TempAlert.Storage` module provides a unified interface to interact with the storage backend,
  which can be either in-memory using Agent or persistent using Redis.
  """

  @storage Application.compile_env(:temp_alert, :storage, TempAlert.Storage.AgentStorage)

  alias TempAlert.StorageProtocol

  @doc """
  Adds an alert to the storage.
  """
  def add_alert(alert), do: StorageProtocol.add_alert(storage_backend(), alert)

  @doc """
  Retrieves an alert by its ID.
  """
  def get_alert(id), do: StorageProtocol.get_alert(storage_backend(), id)

  @doc """
  Retrieves all alerts from the storage.
  """
  def get_all_alerts, do: StorageProtocol.get_all_alerts(storage_backend())

  @doc """
  Deletes an alert by its ID.
  """
  def delete_alert(id), do: StorageProtocol.delete_alert(storage_backend(), id)

  @doc """
  Retrieves due alerts based on the provided time.
  """
  def get_due_alerts(now), do: StorageProtocol.get_due_alerts(storage_backend(), now)

  defp storage_backend do
    case System.get_env("TA_STORAGE_BACKEND") do
      "redis" -> TempAlert.Storage.RedisStorage
      _ -> TempAlert.Storage.AgentStorage
    end
  end
end
