defmodule TempAlert.Schemas.Alert do
  @moduledoc """
  The `TempAlert.Schemas.Alert` module defines the structure and functions related to alerts.

  This module uses the `Jason.Encoder` protocol to ensure that only specific fields are encoded to JSON. It also provides functions to handle the conversion of datetime fields to a consistent ISO8601 format and to create new `Alert` structs with the necessary fields.

  ## Fields

    - `id`: The unique identifier for the alert.
    - `instance`: The instance related to the alert.
    - `message`: The alert message.
    - `timestamp`: The timestamp when the alert was created.
    - `notify_at`: The time when the alert should be notified.

  ## Functions

    - `new/1`: Creates a new Alert struct and ensures all datetime fields are in ISO8601 format.

  ## Examples

      iex> attrs = %{
      ...>   instance: "example-instance",
      ...>   message: "This is a test alert",
      ...>   notify_at: "2024-07-11T18:43:00.000Z"
      ...> }
      iex> alert = TempAlert.Schemas.Alert.new(attrs)
      %TempAlert.Schemas.Alert{
        id: "some-uuid",
        instance: "example-instance",
        message: "This is a test alert",
        timestamp: "2024-07-11T18:00:00.000Z",
        notify_at: "2024-07-11T18:43:00.000Z",
      }
  """

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

  @doc """
  Creates a new Alert struct and ensures all datetime fields are in ISO8601 format.

  ## Examples

      iex> attrs = %{
      ...>   instance: "example-instance",
      ...>   message: "This is a test alert",
      ...>   notify_at: "2024-07-11T18:43:00.000Z"
      ...> }
      iex> TempAlert.Schemas.Alert.new(attrs)
      %TempAlert.Schemas.Alert{
        id: "some-uuid",
        instance: "example-instance",
        message: "This is a test alert",
        timestamp: "2024-07-11T18:00:00.000Z",
        notify_at: "2024-07-11T18:43:00.000Z",
      }
  """
  @spec new(map()) :: %__MODULE__{}
  def new(attrs) do
    %__MODULE__{
      id: Map.get(attrs, :id, Ecto.UUID.generate()),
      instance: attrs.instance,
      message: attrs.message,
      timestamp: Map.get(attrs, :timestamp, DateTime.utc_now()),
      notify_at: attrs.notify_at
    }
  end
end
