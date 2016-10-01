import Babysitting.Factory

tenants = Babysitting.Repo.all(Babysitting.Tenant)

if length(tenants) == 0 do

  # Let's create the base tenants
  tenant_paris = insert(:tenant_paris)
  tenant_bordeaux = insert(:tenant_bordeaux)
  tenant_london = insert(:tenant_london)

end
