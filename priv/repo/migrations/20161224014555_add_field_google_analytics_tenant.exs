defmodule Babysitting.Repo.Migrations.AddFieldGoogleAnalyticsTenant do
  use Ecto.Migration

  def change do
    alter table(:tenants) do
      add :google_analytics, :string
    end
  end
end
