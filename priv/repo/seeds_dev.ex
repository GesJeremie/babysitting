tenants = [
  %Babysitting.Tenant{
    :name => "Paris",
    :domain => "www.babysittingparis.dev",
    :slug => "paris",
    :facebook => "https://www.facebook.com/parisBabySitting/",
    :locale => "fr_FR"
  },
  %Babysitting.Tenant{
    :name => "Bordeaux",
    :domain => "www.babysittingbordeaux.dev",
    :slug => "bordeaux",
    :facebook =>"https://www.facebook.com/babySittingBordeaux",
    :locale => "fr_FR"
  },
  %Babysitting.Tenant{
    :name => "London",
    :domain => "www.babysittinglondon.co.uk.dev",
    :slug => "london",
    :facebook =>"https://www.facebook.com/Baby-Sitting-London-552729038239860",
    :locale => "en_GB"
  }
]

# Seed tenants
tenants 
  |> Enum.map(fn (x) ->  Babysitting.Repo.insert!(x) end)