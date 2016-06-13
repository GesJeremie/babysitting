# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Babysitting.Repo.insert!(%Babysitting.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

tenants = [
  %{
  :name => "Paris",
  :domain => "www.babysittingparis.dev",
  :slug => "paris"
  },
  %{
  :name => "Bordeaux",
  :domain => "www.babysittingbordeaux.dev",
  :slug => "bordeaux"
  },
  %{
  :name => "London",
  :domain => "www.babysittinglondon.co.uk.dev",
  :slug => "london"
  }]

tenants 
  |> Enum.map(fn (x) do  IO.inspect(x) end) 

"""
Babysitting.Repo.insert!(%Babysitting.Tenant{
  :name => "Paris",
  :domain => "www.babysittingparis.dev",
  :slug => "paris"
});
"""
