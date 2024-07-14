defprotocol TempAlert.StorageProtocol do
  @doc "Adds an alert"
  def add_alert(alert)

  @doc "Retrieves an alert by its ID"
  def get_alert(id)

  @doc "Retrieves all alerts"
  def get_all_alerts(_)

  @doc "Deletes an alert by its ID"
  def delete_alert(id)

  @doc "Retrieves due alerts based on the provided time"
  def get_due_alerts(now)
end
