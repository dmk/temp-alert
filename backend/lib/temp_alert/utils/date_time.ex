defmodule TempAlert.Utils.DateTimeHelper do
  @moduledoc """
  The `TempAlert.Utils.DateTimeHelper` module provides utility functions for working with `DateTime` in Elixir.

  This module contains helper functions to manipulate `DateTime` values, such as adding a specified duration to a `DateTime`.

  ## Functions

    - `add_one_hour/1`: Adds one hour to the given `DateTime` string in ISO8601 format.

  ## Examples

      iex> TempAlert.Utils.DateTimeHelper.add_one_hour("2024-07-11T18:43:00.000Z")
      "2024-07-11T19:43:00.000Z"
  """

  @doc """
  Adds one hour to the given `DateTime`.

  This function takes a `DateTime` string in ISO8601 format, converts it to a `DateTime` struct, adds one hour to it, and returns the updated `DateTime` in ISO8601 format.

  ## Parameters

    - `dt_str`: A `DateTime` string in ISO8601 format.

  ## Returns

    - A `DateTime` string in ISO8601 format, representing the time one hour after the input time.

  ## Examples

      iex> TempAlert.Utils.DateTimeHelper.add_one_hour("2024-07-11T18:43:00.000Z")
      "2024-07-11T19:43:00.000Z"
  """
  @spec add_one_hour(dt_str :: String.t()) :: String.t()
  def add_one_hour(dt_str) do
    {:ok, datetime, _} = DateTime.from_iso8601(dt_str)
    datetime
    |> DateTime.add(3600, :second)
    |> DateTime.to_iso8601()
  end
end
