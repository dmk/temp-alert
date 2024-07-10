defmodule TempAlert.Schemas.Alert do
  @derive {Jason.Encoder,
           only: [
             :id,
             :instance,
             :alert_instance,
             :message,
             :timestamp,
             :notify_at
           ]}
  defstruct [
    :id,
    :instance,
    :alert_instance,
    :message,
    :timestamp,
    :notify_at
  ]
end
