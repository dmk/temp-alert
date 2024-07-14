defprotocol TempAlert.StorageProtocol do
  @doc "Adds an alert"
  def add_alert(storage, alert)

  @doc "Retrieves an alert by its ID"
  def get_alert(storage, id)

  @doc "Retrieves all alerts"
  def get_all_alerts(storage)

  @doc "Deletes an alert by its ID"
  def delete_alert(storage, id)

  @doc "Retrieves due alerts based on the provided time"
  def get_due_alerts(storage, now)
end
