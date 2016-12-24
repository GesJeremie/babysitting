defmodule Babysitting.Repo.Migrations.SetupGoogleAnalyticsTenants do
  import Ecto.Query
  use Ecto.Migration
  alias Babysitting.{Tenant, Repo}

  def change do
    changes = [
      %{slug: "paris", google_analytics_id: "UA-89407874-1"},
      %{slug: "marseille", google_analytics_id: "UA-89407874-2"},
      %{slug: "london", google_analytics_id: "UA-89407874-3"},
    ]

    for change <- changes do
      add_google_analytics_id(change.slug, change.google_analytics_id)
    end

  end

  defp add_google_analytics_id(slug, google_analytics_id) do
    Tenant
    |> where([t], t.slug == ^slug or t.slug == ^"#{slug}-dev")
    |> Repo.update_all(set: [google_analytics: google_analytics_id])
  end

end
