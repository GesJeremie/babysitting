alias Babysitting.Repo
import Babysitting.Factory

# Use french language for the fixtures
FakerElixir.set_locale(:fr)

# Create classified for the base tenants
tenants = Repo.all(Babysitting.Tenant)

for tenant <- tenants do
  insert_list(300, :classified, %{tenant: tenant})
end
