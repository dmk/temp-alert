defmodule TempAlert.Jobs.SendAlerts do
  @moduledoc """
  The `TempAlert.Jobs.SendAlerts` module is responsible for periodically checking for due alerts and sending them.

  This module uses `GenServer` to schedule and manage the periodic task. It interacts with the `Storage` module to retrieve due alerts and uses the `Alertmanager` module to send the alerts.

  ## Functions

    - `start_link/1`: Starts the GenServer.
    - `init/1`: Initializes the GenServer and schedules the first work.
    - `handle_info/2`: Handles the periodic work and reschedules the next execution.
    - `schedule_work/0`: Schedules the next execution of the work.
    - `send_due_alerts/0`: Retrieves due alerts and sends them.

  ## Examples

      iex> TempAlert.Jobs.SendAlerts.start_link([])
      {:ok, #PID<0.123.0>}

      # Alerts will be checked and sent every 10 seconds
  """

  use GenServer
  alias TempAlert.Storage
  alias TempAlert.Utils.Alertmanager
  alias TempAlert.Utils.DateTimeHelper

  @doc """
  Starts the GenServer.

  ## Examples

      iex> TempAlert.Jobs.SendAlerts.start_link([])
      {:ok, #PID<0.123.0>}
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @doc """
  Initializes the GenServer and schedules the first work.

  ## Examples

      iex> TempAlert.Jobs.SendAlerts.init(%{})
      {:ok, %{}}
  """
  def init(state) do
    schedule_work()
    {:ok, state}
  end

  @doc """
  Handles the periodic work and reschedules the next execution.

  ## Examples

      iex> TempAlert.Jobs.SendAlerts.handle_info(:work, %{})
      {:noreply, %{}}
  """
  def handle_info(:work, state) do
    send_due_alerts()
    schedule_work()
    {:noreply, state}
  end

  @doc """
  Schedules the next execution of the work.

  ## Examples

      iex> TempAlert.Jobs.SendAlerts.schedule_work()
      :ok
  """
  defp schedule_work do
    Process.send_after(self(), :work, :timer.seconds(10))
  end

  @doc """
  Retrieves due alerts and sends them.

  ## Examples

      iex> TempAlert.Jobs.SendAlerts.send_due_alerts()
      :ok
  """
  defp send_due_alerts do
    now = DateTime.utc_now()
    due_alerts = Storage.get_due_alerts(now)

    Enum.each(due_alerts, fn alert ->
      Alertmanager.create_alert(alert)
    end)
  end
end
