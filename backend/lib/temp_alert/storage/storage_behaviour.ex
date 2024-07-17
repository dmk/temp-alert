defmodule TempAlert.StorageBehaviour do
  @callback add_alert(alert :: map()) :: any()
  @callback get_alert(id :: any()) :: any()
  @callback get_all_alerts() :: list()
  @callback delete_alert(id :: any()) :: any()
  @callback get_due_alerts(now :: DateTime.t()) :: list()
end
