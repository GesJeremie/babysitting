defmodule Babysitting.Repo.Migrations.SetupHotjarTenants do
  import Ecto.Query
  use Ecto.Migration
  alias Babysitting.{Tenant, Repo}

  def change do
    changes = [
      %{slug: "paris", hotjar_id: "375470"},
      %{slug: "marseille", hotjar_id: "375473"},
      %{slug: "london", hotjar_id: "375472"},
    ]

    for change <- changes do
      add_hotjar_id(change.slug, change.hotjar_id)
    end

  end

  defp add_hotjar_id(slug, hotjar_id) do
    Tenant
    |> where([t], t.slug == ^slug or t.slug == ^"#{slug}-dev")
    |> Repo.update_all(set: [hotjar: hotjar_id])
  end

end
