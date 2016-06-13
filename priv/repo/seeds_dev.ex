tenants = [
  %Babysitting.Tenant{
    :name => "Paris",
    :domain => "www.babysittingparis.dev",
    :slug => "paris"
  },
  %Babysitting.Tenant{
    :name => "Bordeaux",
    :domain => "www.babysittingbordeaux.dev",
    :slug => "bordeaux"
  },
  %Babysitting.Tenant{
    :name => "London",
    :domain => "www.babysittinglondon.co.uk.dev",
    :slug => "london"
  }
]

# Seed tenants
tenants 
  |> Enum.map(fn (x) ->  Babysitting.Repo.insert!(x) end)