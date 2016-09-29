# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :babysitting, Babysitting.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "iYH8/ETe3SGC3vpRyq00B3hZ9rOekYTPFh78w5yK8AmRugTvjyPmvvV9Qy3OEizW",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Babysitting.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :babysitting, ecto_repos: [Babysitting.Repo]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures scrivener
config :scrivener_html,
  routes_helper: Babysitting.Router.Helpers

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

