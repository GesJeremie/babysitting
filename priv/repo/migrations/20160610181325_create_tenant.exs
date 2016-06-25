defmodule Babysitting.Repo.Migrations.CreateTenant do
  use Ecto.Migration

  def change do
    create table(:tenants) do
      add :name, :string
      add :domain, :string
      add :slug, :string
      add :facebook, :string
      add :locale, :string
      timestamps
    end

  end
end
