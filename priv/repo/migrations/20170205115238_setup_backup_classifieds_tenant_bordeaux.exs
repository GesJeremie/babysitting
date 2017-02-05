defmodule Babysitting.Repo.Migrations.SetupBackupClassifiedsTenantBordeaux do
  import Ecto
  import Ecto.Query, only: [from: 1, from: 2]

  use Ecto.Migration
  alias Babysitting.Classified
  alias Babysitting.Tenant
  alias Babysitting.Changesets.ClassifiedChangeset
  alias Babysitting.Repo

  def change do
    if Mix.env == :prod do
      do_change()
    end
  end

  defp do_change do
    classifieds = fetch_classifieds()
    tenant = fetch_tenant()

    for classified <- classifieds do

      record = ClassifiedChangeset.create_by_migration(%Classified{}, %{
        firstname: classified["firstname"],
        lastname: classified["lastname"],
        email: classified["email"],
        password: "babysittingbordeaux",
        phone: classified["phone"],
        birthday: "#{padding(classified["birthday_day"])}/#{padding(classified["birthday_month"])}/#{classified["birthday_year"]}",
        description: classified["content"],
        avatar: Path.expand("priv/repo/setup_tenant_bordeaux/avatars/#{classified["avatar"]}"),
        tenant_id: tenant.id,
        valid: true,
        posted_on_facebook: true,
        inserted_at: classified["created_at"]
      })

      Repo.insert!(record)
    end
  end

  defp fetch_classifieds do
    file = Path.expand("priv/repo/setup_tenant_bordeaux/classifieds.json")
    {:ok, classifieds} = File.read(file)

    Poison.decode!(classifieds)
  end

  defp fetch_tenant do
    Tenant
    |> Tenant.where(:slug, "bordeaux")
    |> Repo.one!
  end

  defp padding(value) do
    length = value |> Integer.to_string |> String.length

    if length == 1 do
      "0#{value}"
    else
      value
    end
  end

end
