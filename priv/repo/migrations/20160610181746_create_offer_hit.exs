defmodule Babysitting.Repo.Migrations.CreateOfferHit do
  use Ecto.Migration

  def change do
    create table(:offer_hits) do
      add :offer_id, references(:offers)
      add :ip, :string

      timestamps
    end

  end
end
