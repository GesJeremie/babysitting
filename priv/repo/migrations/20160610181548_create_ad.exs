defmodule Babysitting.Repo.Migrations.CreateAd do
  use Ecto.Migration

  def change do
    create table(:ads) do
      add :tenant_id, references(:tenants)
      add :email, :string
      add :password, :string
      add :firstname, :string
      add :lastname, :string
      add :phone, :string
      add :birthday, :string
      add :description, :text
      add :avatar, :string
      add :token, :string
      add :search, :text
      add :status, :boolean
      add :valid, :boolean
      add :reason, :text

      timestamps
    end

    create unique_index(:ads, [:email])

  end
end
