defmodule TempAlert.Storage do
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
