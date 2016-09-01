alias Babysitting.Repo
import Babysitting.Fixtures

# Let's make french the fixtures
FakerElixir.set_locale(:fr)

# Let's create the base tenants
tenant_paris = fixture(:tenant, :paris)
tenant_bordeaux = fixture(:tenant, :bordeaux)
tenant_london = fixture(:tenant, :london)

# Some classifieds for tenant paris
Stream.repeatedly(fn -> fixture(:classified, tenant: tenant_paris) end)
|> Enum.take(30)

# Some classifieds for tenant bordeaux
Stream.repeatedly(fn -> fixture(:classified, tenant: tenant_bordeaux) end)
|> Enum.take(30)

# Some classifieds for tenant london
Stream.repeatedly(fn -> fixture(:classified, tenant: tenant_london) end)
|> Enum.take(30)
