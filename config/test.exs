use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :babysitting, Babysitting.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :babysitting, Babysitting.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "babysitting_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :babysitting,
       email_address: "group.babysitting@gmail.com",
       admin_password: "babysittingrocksdude"

config :babysitting, Babysitting.Mailer,
  adapter: Bamboo.TestAdapter
