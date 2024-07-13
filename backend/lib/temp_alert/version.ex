defmodule TempAlert.Version do
  @moduledoc """
  The `TempAlert.Version` module provides functionality to retrieve the current version of the application.

  This module reads the version from a `VERSION` file located in the root directory of the project. It provides a single function `version/0` to access the version string.

  ## Functions

    - `version/0`: Returns the current version of the application.

  ## Examples

      iex> TempAlert.Version.version()
      "0.1.0"

  The `VERSION` file should contain the version string, for example:

      0.1.0
  """

  @version File.read!("VERSION") |> String.trim()

  @doc """
  Returns the current version of the application.

  ## Examples

      iex> TempAlert.Version.version()
      "0.1.0"
  """
  def version, do: @version
end
