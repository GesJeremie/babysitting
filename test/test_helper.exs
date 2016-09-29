ExUnit.start

# Execute task alias test.setup (check mix.exs file)
Mix.Task.run "test.setup", ~w(-r Babysitting.Repo --quiet)

Ecto.Adapters.SQL.Sandbox.mode(Babysitting.Repo, :manual)