# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

defmodule TempAlert.ConfigHelper do
  def storage_backend do
    case System.get_env("TA_STORAGE_BACKEND") do
      "redis" -> TempAlert.Storage.RedisStorage
      _ -> TempAlert.Storage.AgentStorage
    end
  end
end

# Configures the endpoint
config :temp_alert, TempAlertWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: TempAlertWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TempAlert.PubSub,
  live_view: [signing_salt: "a6wROBOU"]

# Set base path
IO.inspect(System.get_env("TA_BASE_PATH", "/"), label: "TA_BASE_PATH")
config :temp_alert, :base_path, System.get_env("TA_BASE_PATH", "/")

# Fetch the log level from the environment variable, default to :info if not set
log_level =
  System.get_env("TA_LOG_LEVEL", "info")
  |> String.downcase()
  |> String.to_atom()

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger, level: log_level

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Pick storage backend
config :temp_alert, :storage, TempAlert.ConfigHelper.storage_backend()

if System.get_env("TA_STORAGE_BACKEND") == "redis" do
  config :temp_alert, :redis,
    host: System.get_env("TA_REDIS_HOST", "localhost"),
    port: String.to_integer(System.get_env("TA_REDIS_PORT", "6379")),
    password: System.get_env("TA_REDIS_PASSWORD")
end

config :temp_alert,
       :send_alerts_interval,
       String.to_integer(System.get_env("TA_SEND_ALERTS_INTERVAL", "60"))

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
