defmodule Babysitting.Repo.Migrations.SetupTenantBordeaux do
  use Ecto.Migration

  def change do
    # For production
    create_tenant(:bordeaux, "www.babysittingbordeaux.fr", "bordeaux")

    # For development purposes
    create_tenant(:bordeaux, "www.babysittingbordeaux.dev", "bordeaux-dev")
  end

  defp create_tenant(:bordeaux, domain, slug) do
    Babysitting.Repo.insert!(%Babysitting.Tenant{
      :name => "Bordeaux",
      :domain => domain,
      :slug => slug,
      :facebook => "https://www.facebook.com/babySittingBordeaux/",
      :locale => "fr_FR",
      :hotjar => "406723",
      :google_analytics => "UA-89407874-4"
    })
  end

end
