defmodule Babysitting.Repo.Migrations.CreateOfferContact do
  use Ecto.Migration

  def change do
    create table(:offer_contacts) do
      add :offer_id, :integer
      add :email, :string
      add :message, :text
      add :phone, :string

      timestamps
    end

  end
end
