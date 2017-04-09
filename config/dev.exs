use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :babysitting, Babysitting.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: ["front/node_modules/brunch/bin/brunch", "watch", "front"]
  ]

# Watch static and templates for browser reloading.
config :babysitting, Babysitting.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :babysitting, Babysitting.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "babysitting_dev",
  hostname: "localhost",
  pool_size: 10

config :babysitting,
       email_address: "group.babysitting@gmail.com",
       admin_password: "admin",
       stripe_key: "sk_test_0AnnutaWqFGizdL8INnggsab"

config :babysitting, Babysitting.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "mailtrap.io",
  port: 2525,
  username: "784554979ecabb",
  password: "a3568f06c9698b",
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1
