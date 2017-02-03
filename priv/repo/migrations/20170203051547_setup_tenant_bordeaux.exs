defmodule Babysitting.Repo.Migrations.SetupTenantBordeaux do
  use Ecto.Migration

  def change do
    # For production
    create_tenant(:bordeaux, "www.babysittingbordeaux.fr")

    # For development purposes
    create_tenant(:bordeaux, "www.babysittingbordeaux.dev")
  end

  defp create_tenant(:bordeaux, domain) do
    Babysitting.Repo.insert!(%Babysitting.Tenant{
      :name => "Bordeaux",
      :domain => domain,
      :slug => "bordeaux",
      :facebook => "https://www.facebook.com/babySittingBordeaux/",
      :locale => "fr_FR",
      :hotjar => "406723",
      :google_analytics => "UA-89407874-4"
    })
  end

end
