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
       ifttt_key: "VCDRxG7MqAtP68lM2wEHtCr66sjo73HuWlBF6sNWMk",
       admin_password: "babysittingrocksdude"

config :keenex,
  project_id: "57aeaf313831444167e1fa35",
  write_key: "b90d7934bb1d121351a8cad5ec0b4687a81f86e47186d2812cf531f3e7bb62025622b50482fa18d03565d7815f0eaebab74a444af9b7dbfa94fc7621eec1e8ef786da80339a9b642402c893a52b8967a5b7241df69783d2c782ed66f82f1cc47",
  read_key: "410e0b58f9d6c3371cd296341701dc9758bd8b47d9def44aff868ba6cfd54dfe394b8eb113a55c8dc4df2042975da73e7bcc9e397e1e8ca48f75607fd2caa712359db81d2cc304029fc6b20cc34795344551caf82419a8744bc650f9a8b910ac"

config :babysitting, Babysitting.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "mailtrap.io",
  port: 2525,
  username: "784554979ecabb",
  password: "a3568f06c9698b",
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1
