import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :counter, CounterWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "wOdRvFcXi/0NeTCT7Gjz55VuEgQJgQ9WXX5PNQFpBRxatu7CfWf0y3Y0eQ0vqOmO",
  server: false

# In test we don't send emails.
config :counter, Counter.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
