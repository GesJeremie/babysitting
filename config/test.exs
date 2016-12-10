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
       ifttt_key: "VCDRxG7MqAtP68lM2wEHtCr66sjo73HuWlBF6sNWMk",
       admin_password: "babysittingrocksdude"

config :keenex,
  project_id: "57aeaf313831444167e1fa35",
  write_key: "b90d7934bb1d121351a8cad5ec0b4687a81f86e47186d2812cf531f3e7bb62025622b50482fa18d03565d7815f0eaebab74a444af9b7dbfa94fc7621eec1e8ef786da80339a9b642402c893a52b8967a5b7241df69783d2c782ed66f82f1cc47",
  read_key: "410e0b58f9d6c3371cd296341701dc9758bd8b47d9def44aff868ba6cfd54dfe394b8eb113a55c8dc4df2042975da73e7bcc9e397e1e8ca48f75607fd2caa712359db81d2cc304029fc6b20cc34795344551caf82419a8744bc650f9a8b910ac"

config :babysitting, Babysitting.Mailer,
  adapter: Bamboo.TestAdapter
