defmodule TempAlert.Utils.DateTimeHelper do
  @doc """
  Adds one hour to the given DateTime.
  """
  @spec add_one_hour(dt_str :: String) :: DateTime.t()
  def add_one_hour(dt_str) do
    {:ok, datetime, _} = DateTime.from_iso8601(dt_str)
    datetime
    |> DateTime.add(3600, :second)
    |> DateTime.to_iso8601
  end
end
