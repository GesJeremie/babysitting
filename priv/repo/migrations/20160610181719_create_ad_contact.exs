defmodule Babysitting.Repo.Migrations.CreateOfferContact do
  use Ecto.Migration

  def change do
    create table(:ad_contacts) do
      add :ad_id, references(:ads)
      add :email, :string
      add :message, :text
      add :phone, :string

      timestamps
    end

  end
end
