defmodule Babysitting.Repo.Migrations.SetupTenantPhilly do
  use Ecto.Migration

  def change do
    # For production
    create_tenant(:philly, "www.babysittingphilly.com")

    # For development purposes
    create_tenant(:philly, "www.babysittingphilly.dev")
  end

  defp create_tenant(:philly, domain) do
    Babysitting.Repo.insert!(%Babysitting.Tenant{
      :name => "Philly",
      :domain => domain,
      :slug => "philly",
      :facebook => "https://www.facebook.com/babysittingphilly",
      :locale => "en_US",
      :hotjar => "435776",
      :google_analytics => "UA-89407874-5"
    })
  end

end
