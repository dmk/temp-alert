defmodule TempAlert.Schemas.AlertTest do
  use ExUnit.Case, async: true

  alias TempAlert.Schemas.Alert

  describe "new/1" do
    test "creates a new alert with all fields" do
      attrs = %{
        instance: "example-instance",
        message: "This is a test alert",
        notify_at: "2024-07-11T18:43:00.000Z"
      }

      alert = Alert.new(attrs)

      assert %Alert{} = alert
      assert alert.id != nil
      assert alert.instance == "example-instance"
      assert alert.message == "This is a test alert"
      assert alert.timestamp != nil
      assert alert.notify_at == "2024-07-11T18:43:00.000Z"
    end

    test "uses provided id if given" do
      attrs = %{
        id: "custom-id",
        instance: "example-instance",
        message: "This is a test alert",
        notify_at: "2024-07-11T18:43:00.000Z"
      }

      alert = Alert.new(attrs)

      assert %Alert{} = alert
      assert alert.id == "custom-id"
    end

    test "generates a new id if not provided" do
      attrs = %{
        instance: "example-instance",
        message: "This is a test alert",
        notify_at: "2024-07-11T18:43:00.000Z"
      }

      alert = Alert.new(attrs)

      assert %Alert{} = alert
      assert alert.id != nil
    end

    test "sets the current timestamp if not provided" do
      attrs = %{
        instance: "example-instance",
        message: "This is a test alert",
        notify_at: "2024-07-11T18:43:00.000Z"
      }

      alert = Alert.new(attrs)

      assert %Alert{} = alert
      assert alert.timestamp != nil
    end

    test "uses provided timestamp if given" do
      now = DateTime.utc_now()
      attrs = %{
        instance: "example-instance",
        message: "This is a test alert",
        timestamp: now,
        notify_at: "2024-07-11T18:43:00.000Z"
      }

      alert = Alert.new(attrs)

      assert %Alert{} = alert
      assert alert.timestamp == now
    end
  end
end
