defmodule TempAlert.AlertsAgent do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def add_alert(alert) do
    Agent.update(__MODULE__, &Map.put(&1, alert.id, alert))
  end

  def get_alert(id) do
    Agent.get(__MODULE__, &Map.get(&1, id))
  end

  def get_all_alerts do
    Agent.get(__MODULE__, &Map.values(&1))
  end

  def delete_alert(id) do
    Agent.update(__MODULE__, &Map.delete(&1, id))
  end
end
