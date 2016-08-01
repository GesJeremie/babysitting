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
  %Babysitting.Tenant{
    :name => "Paris",
    :domain => "www.babysittingparis.fr",
    :slug => "paris",
    :facebook => "https://www.facebook.com/parisBabySitting/",
    :locale => "fr-FR"
  },
  %Babysitting.Tenant{
    :name => "Bordeaux",
    :domain => "www.babysittingbordeaux.fr",
    :slug => "bordeaux",
    :facebook => "https://www.facebook.com/babySittingBordeaux",
    :locale => "fr-FR"
  },
  %Babysitting.Tenant{
    :name => "London",
    :domain => "www.babysittinglondon.co.uk",
    :slug => "london",
    :facebook => "https://www.facebook.com/Baby-Sitting-London-552729038239860",
    :locale => "en-GB"
  }
]

# Seed tenants
tenants 
  |> Enum.map(fn (tenant) ->  Babysitting.Repo.insert!(tenant) end)
