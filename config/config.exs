# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stasi,
  ecto_repos: [Stasi.Repo]

# Configures the endpoint
config :stasi, StasiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Dm3vAo4fuwCxw2tXdC2UDIOKIs6DVpRy5Ctmw00CI1Xp5kaTiGZoiUA25E4t5Y95",
  render_errors: [view: StasiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Stasi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
