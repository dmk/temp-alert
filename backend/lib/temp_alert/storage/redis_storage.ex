defmodule TempAlert.Storage.RedisStorage do
  @behaviour TempAlert.StorageBehaviour

  use GenServer

  alias TempAlert.Schemas.Alert
  @redis_key "alerts"

  def start_link(_) do
    redix_config = Application.get_env(:temp_alert, :redis)

    Redix.start_link(
      host: redix_config[:host],
      port: redix_config[:port],
      password: redix_config[:password],
      name: __MODULE__
    )
  end

  @impl true
  def add_alert(alert) do
    Redix.command!(__MODULE__, ["HSET", @redis_key, alert.id, Jason.encode!(alert)])
  end

  @impl true
  def get_alert(id) do
    case Redix.command!(__MODULE__, ["HGET", @redis_key, id]) do
      nil -> nil
      alert_json -> Jason.decode!(alert_json, as: %Alert{}, keys: :atoms)
    end
  end

  @impl true
  def get_all_alerts do
    Redix.command!(__MODULE__, ["HGETALL", @redis_key])
    |> Enum.chunk_every(2)
    |> Enum.map(fn [id, alert_json] -> Jason.decode!(alert_json, as: %Alert{}, keys: :atoms) end)
  end

  @impl true
  def delete_alert(id) do
    Redix.command!(__MODULE__, ["HDEL", @redis_key, id])
  end

  @impl true
  def get_due_alerts(now) do
    get_all_alerts()
    |> Enum.filter(fn alert ->
      {:ok, notify_at, _} = DateTime.from_iso8601(alert.notify_at)
      DateTime.compare(notify_at, now) != :gt
    end)
  end
end
