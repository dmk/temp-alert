import Config

# TODO: Configure your database

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :temp_alert, TempAlertWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "zUKN+DaoYObeeX5G054qajmGSzY4ECy4cMJzVdr7hJSetAe1qZCQ8NDfvfi+gtiX",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
