defmodule TempAlert.Storage.AgentStorage do
  @behaviour TempAlert.StorageBehaviour

  use Agent
  alias TempAlert.Schemas.Alert

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
      Enum.filter(alerts, fn {_id, alert} ->
        {:ok, notify_at, _} = DateTime.from_iso8601(alert.notify_at)
        DateTime.compare(notify_at, now) != :gt
      end)
      |> Enum.map(fn {_id, alert} -> alert end)
    end)
  end
end
