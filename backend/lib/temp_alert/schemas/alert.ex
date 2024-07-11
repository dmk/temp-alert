defmodule TempAlert.Schemas.Alert do
  @derive {Jason.Encoder,
           only: [
             :id,
             :instance,
             :message,
             :timestamp,
             :notify_at
           ]}
  defstruct [
    :id,
    :instance,
    :message,
    :timestamp,
    :notify_at
  ]
end
