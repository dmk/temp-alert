defmodule TempAlert.Utils.AlertmanagerTest do
  use ExUnit.Case, async: true

  alias TempAlert.Schemas.Alert
  alias TempAlert.Utils.Alertmanager

  @alert %Alert{
    instance: "example-instance",
    message: "This is a test alert",
    timestamp: DateTime.utc_now(),
    notify_at: DateTime.add(DateTime.utc_now(), 60)
  }

  test "prepare_payload/1 prepares the correct payload" do
    payload = Alertmanager.prepare_payload(@alert)
    assert payload["labels"]["alertname"] == "TempAlert"
    assert payload["labels"]["instance"] == @alert.instance
    assert payload["annotations"]["summary"] == @alert.message
  end
end
