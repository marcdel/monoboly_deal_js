# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :monoboly_deal,
  ecto_repos: [MonobolyDeal.Repo]

# Configures the endpoint
config :monoboly_deal, MonobolyDealWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9B70rPR9d7QoClNDBMns0jOxSrbRj0LYzg0SGP8xaXdRh/3i3+Org65Aq9VO4wja",
  render_errors: [view: MonobolyDealWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MonobolyDeal.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
