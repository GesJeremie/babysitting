defmodule Babysitting.Repo.Migrations.ChangeSetupBaseTenants do
  import Ecto
  import Ecto.Changeset
  import Ecto.Query
  use Ecto.Migration
  alias Babysitting.{Tenant, Repo}

  def change do
    edit_tenant(:paris, :dev)
    edit_tenant(:london, :prod)
    edit_tenant(:london, :dev)
    
    create_tenant(:marseille, "www.babysittingmarseille.fr", "marseille")
    create_tenant(:marseille, "www.babysittingmarseille.dev", "marseille-dev")
  end

  defp edit_tenant(:paris, :dev) do
    Tenant 
    |> where(domain: "www.babysittingparis.fr.dev")
    |> Repo.update_all(set: [domain: "www.babysittingparis.dev", slug: "paris-dev"])
  end

  defp edit_tenant(:london, :prod) do
    Tenant 
    |> where(domain: "www.babysittinglondon.co.uk")
    |> Repo.update_all(set: [domain: "www.babysittinglondon.com", slug: "london"])
  end

  defp edit_tenant(:london, :dev) do
    Tenant 
    |> where(domain: "www.babysittinglondon.co.uk.dev")
    |> Repo.update_all(set: [domain: "www.babysittinglondon.dev", slug: "london-dev"])
  end

  defp create_tenant(:marseille, domain, slug) do
    Babysitting.Repo.insert!(%Babysitting.Tenant{
      :name => "Marseille",
      :domain => domain,
      :slug => slug,
      :facebook => "https://www.facebook.com/Baby-Sitting-Marseille-184713158658939",
      :locale => "fr_FR"
    })
  end

end
