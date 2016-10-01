alias Babysitting.Repo
import Babysitting.Factory

# Let's make french the fixtures
FakerElixir.set_locale(:fr)

# Let's create the base tenants
tenant_paris = insert(:tenant_paris)
tenant_bordeaux = insert(:tenant_bordeaux)
tenant_london = insert(:tenant_london)

# Create classified
insert_list(300, :classified, %{tenant: tenant_paris})
insert_list(300, :classified, %{tenant: tenant_bordeaux})
insert_list(300, :classified, %{tenant: tenant_london})
