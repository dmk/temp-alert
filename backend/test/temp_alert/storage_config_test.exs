defmodule TempAlert.StorageConfigTest do
  use ExUnit.Case, async: true

  setup do
    # Preserve the original configuration
    original_storage = Application.get_env(:temp_alert, :storage)
    on_exit(fn -> Application.put_env(:temp_alert, :storage, original_storage) end)
    :ok
  end

  test "uses RedisStorage when STORAGE_BACKEND is set to 'redis'" do
    Application.put_env(:temp_alert, :storage, TempAlert.Storage.RedisStorage)
    System.put_env("STORAGE_BACKEND", "redis")
    assert Application.get_env(:temp_alert, :storage) == TempAlert.Storage.RedisStorage
  end

  test "uses FileStorage when STORAGE_BACKEND is set to 'file'" do
    Application.put_env(:temp_alert, :storage, TempAlert.Storage.FileStorage)
    System.put_env("STORAGE_BACKEND", "file")
    assert Application.get_env(:temp_alert, :storage) == TempAlert.Storage.FileStorage
  end

  test "uses AgentStorage by default when STORAGE_BACKEND is not set" do
    Application.put_env(:temp_alert, :storage, TempAlert.Storage.AgentStorage)
    System.delete_env("STORAGE_BACKEND")
    assert Application.get_env(:temp_alert, :storage) == TempAlert.Storage.AgentStorage
  end
end
