alias Babysitting.Repo
import Babysitting.Fixtures

# Let's make french the fixtures
FakerElixir.set_locale(:fr)

# Let's create the base tenants
tenant_paris = fixture(:tenant, :paris)
tenant_bordeaux = fixture(:tenant, :bordeaux)
tenant_london = fixture(:tenant, :london)

# Create classifieds
Stream.repeatedly(fn -> fixture(:classified, tenant: tenant_paris) end)
|> Enum.take(30)


# Create contacts
Stream.repeatedly(fn -> fixture(:classified, tenant: FakerElixir.Helper.pick([tenant_paris, tenant_bordeaux, tenant_london])) end)
|> Enum.take(30)
