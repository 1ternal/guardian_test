# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the namespace used by Phoenix generators
config :guardian_test,
  app_namespace: GT

# Configures the endpoint
config :guardian_test, GT.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "F2fM03JZ4PMPuYcXZYLJ5r7grvS9NCOrpoN0epVy+YaWPKx08B4PcS2lQy0MuS1G",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: GT.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "GT",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "F2fM03JZ4PMPuYcXZYLJ5r7grvS9NCOrpoN0epVy",
  serializer: GT.GuardianSerializer
