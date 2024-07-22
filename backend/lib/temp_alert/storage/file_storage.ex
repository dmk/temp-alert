defmodule TempAlert.Storage.FileStorage do
  @moduledoc """
  File-based storage implementation using Agent.
  """

  @behaviour TempAlert.StorageBehaviour

  use Agent

  def start_link(_) do
    base_path = get_base_path()
    File.mkdir_p!(base_path)

    initial_state = load_alerts(base_path)
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  @impl true
  def add_alert(alert) do
    Agent.update(__MODULE__, fn state ->
      save_alert(alert)
      Map.put(state, alert.id, alert)
    end)
  end

  @impl true
  def get_alert(id) do
    Agent.get(__MODULE__, fn state -> Map.get(state, id) end)
  end

  @impl true
  def get_all_alerts do
    Agent.get(__MODULE__, fn state -> Map.values(state) end)
  end

  @impl true
  def delete_alert(id) do
    Agent.update(__MODULE__, fn state ->
      delete_alert_file(id)
      Map.delete(state, id)
    end)
  end

  @impl true
  def get_due_alerts(now) do
    get_all_alerts()
    |> Enum.filter(fn alert -> DateTime.before?(alert.notify_at, now) end)
  end

  defp get_base_path do
    Application.get_env(:temp_alert, :file_storage_path, "data")
  end

  defp load_alerts(base_path) do
    base_path
    |> File.ls!()
    |> Enum.filter(&String.ends_with?(&1, ".bin"))
    |> Enum.map(fn file ->
      file_path = Path.join(base_path, file)
      {:ok, binary} = File.read(file_path)
      {Path.basename(file, ".bin"), :erlang.binary_to_term(binary)}
    end)
    |> Enum.into(%{})
  end

  defp save_alert(alert) do
    file_path = Path.join(get_base_path(), "#{alert.id}.bin")
    File.write!(file_path, :erlang.term_to_binary(alert))
  end

  defp delete_alert_file(id) do
    file_path = Path.join(get_base_path(), "#{id}.bin")
    File.rm(file_path)
  end
end
