ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Babysitting.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Babysitting.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Babysitting.Repo)

