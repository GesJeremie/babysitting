defmodule Babysitting.Repo.Migrations.CreateContact do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :tenant_id, references(:tenants)
      add :email, :string
      add :message, :text

      timestamps
    end

  end
end
