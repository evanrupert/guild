# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :guild,
  ecto_repos: [Guild.Repo]

# Configures the endpoint
config :guild, GuildWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "W3wnJB5ssetTmkvL/C4miwlPJ+KJq8gN/ivEJ4XGr4yrAGkM4BGfvVU+7Fd1yYzw",
  render_errors: [view: GuildWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Guild.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
