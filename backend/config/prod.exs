import Config

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
config :temp_alert, TempAlertWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000]

# Set Alertmanager API URL
config :temp_alert, :alertmanager_url, System.get_env("TA_ALERTMANAGER_URL")
