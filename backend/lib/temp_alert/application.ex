defmodule TempAlert.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TempAlertWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:temp_alert, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TempAlert.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TempAlert.Finch},

      # Start the Alerts Agent
      Application.get_env(:temp_alert, :storage),

      # Start the job sending alerts
      TempAlert.Jobs.SendAlerts,

      # Start a worker by calling: TempAlert.Worker.start_link(arg)
      # {TempAlert.Worker, arg},
      # Start to serve requests, typically the last entry
      TempAlertWeb.Endpoint,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TempAlert.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TempAlertWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
