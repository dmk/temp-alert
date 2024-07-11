defmodule TempAlert.Version do
  @version File.read!("VERSION") |> String.trim()
  def version, do: @version
end
