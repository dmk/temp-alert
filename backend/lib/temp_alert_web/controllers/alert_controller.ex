defmodule TempAlertWeb.AlertController do
  use TempAlertWeb, :controller
  alias TempAlert.Storage
  alias TempAlert.Schemas.Alert

  def create(conn, %{
        "instance" => instance,
        "message" => message,
        "notify_at" => notify_at
      }) do
    id = Ecto.UUID.generate()
    timestamp = DateTime.utc_now()

    alert = %Alert{
      id: id,
      instance: instance,
      message: message,
      notify_at: notify_at,
      timestamp: timestamp
    }

    Storage.add_alert(alert)
    json(conn, alert)
  end

  def index(conn, _params) do
    alerts = Storage.get_all_alerts()
    json(conn, alerts)
  end

  def show(conn, %{"id" => id}) do
    alert = Storage.get_alert(id)
    json(conn, alert)
  end

  def delete(conn, %{"id" => id}) do
    Storage.delete_alert(id)
    send_resp(conn, :no_content, "")
  end
end
