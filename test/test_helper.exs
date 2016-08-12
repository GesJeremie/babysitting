ExUnit.start

# Execute task alias test.setup (check mix.exs file)
Mix.Task.run "test.setup", ~w(-r Babysitting.Repo --quiet)

Ecto.Adapters.SQL.begin_test_transaction(Babysitting.Repo)
