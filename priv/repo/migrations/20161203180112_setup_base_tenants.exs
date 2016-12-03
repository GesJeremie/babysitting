defmodule Babysitting.Repo.Migrations.SetupBaseTenants do
  use Ecto.Migration

  def change do
    # For production
    create_tenant(:paris, "www.babysittingparis.fr")
    create_tenant(:london, "www.babysittinglondon.co.uk")

    # For development purposes
    create_tenant(:paris, "www.babysittingparis.fr.dev")
    create_tenant(:london, "www.babysittinglondon.co.uk.dev")
  end

  defp create_tenant(:paris, domain) do
    Babysitting.Repo.insert!(%Babysitting.Tenant{
      :name => "Paris",
      :domain => domain,
      :slug => "paris",
      :facebook => "https://www.facebook.com/parisBabySitting/",
      :locale => "fr_FR"
    })
  end

  defp create_tenant(:london, domain) do
    Babysitting.Repo.insert!(%Babysitting.Tenant{
      :name => "London",
      :domain => domain,
      :slug => "london",
      :facebook =>"https://www.facebook.com/Baby-Sitting-London-552729038239860",
      :locale => "en_GB"
    })
  end

end
