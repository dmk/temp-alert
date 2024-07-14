defmodule TempAlert.Storage.AgentStorage do
  use Agent
  alias TempAlert.StorageProtocol

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  defimpl StorageProtocol, for: TempAlert.Storage.AgentStorage do
    def add_alert(_storage, alert) do
      Agent.update(__MODULE__, &Map.put(&1, alert.id, alert))
    end

    def get_alert(_storage, id) do
      Agent.get(__MODULE__, &Map.get(&1, id))
    end

    def get_all_alerts(_storage) do
      Agent.get(__MODULE__, &Map.values(&1))
    end

    def delete_alert(_storage, id) do
      Agent.update(__MODULE__, &Map.delete(&1, id))
    end

    def get_due_alerts(_storage, now) do
      Agent.get(__MODULE__, fn alerts ->
        Enum.filter(alerts, fn {_id, alert} ->
          {:ok, notify_at, _} = DateTime.from_iso8601(alert.notify_at)
          DateTime.compare(notify_at, now) != :gt
        end)
        |> Enum.map(fn {_id, alert} -> alert end)
      end)
    end
  end
end
