defmodule Babysitting.Repo.Migrations.CreateOffer do
  use Ecto.Migration

  def change do
    create table(:offers) do
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

      timestamps
    end

    create unique_index(:offers, [:email])

  end
end
