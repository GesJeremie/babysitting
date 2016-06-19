tenants = [
  %Babysitting.Tenant{
    :name => "Paris",
    :domain => "www.babysittingparis.dev",
    :slug => "paris",
    :facebook =>"https://www.facebook.com/parisBabySitting/"
  },
  %Babysitting.Tenant{
    :name => "Bordeaux",
    :domain => "www.babysittingbordeaux.dev",
    :slug => "bordeaux",
    :facebook =>"https://www.facebook.com/babySittingBordeaux"
  },
  %Babysitting.Tenant{
    :name => "London",
    :domain => "www.babysittinglondon.co.uk.dev",
    :slug => "london",
    :facebook =>"https://www.facebook.com/Baby-Sitting-London-552729038239860"
  }
]

# Seed tenants
tenants 
  |> Enum.map(fn (x) ->  Babysitting.Repo.insert!(x) end)