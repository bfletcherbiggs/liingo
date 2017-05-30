# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :liingoew,
  ecto_repos: [Liingoew.Repo]

# Configures the endpoint
config :liingoew, Liingoew.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ptzc11wKmiOB5YAum5rG2/QdfswrNuBRUPDvIx284P34jrYqr6AmIZJT1cZzXuB6",
  render_errors: [view: Liingoew.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Liingoew.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Liingoew.#{Mix.env}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Liingoew.GuardianSerializer,
  secret_key: to_string(Mix.env)

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
