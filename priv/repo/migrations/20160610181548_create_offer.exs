defmodule Babysitting.Repo.Migrations.CreateOffer do
  use Ecto.Migration

  def change do
    create table(:offers) do
      add :tenant_id, :integer
      add :firstname, :string
      add :lastname, :string
      add :phone, :string
      add :day_birthday, :integer
      add :month_birthday, :string
      add :year_birthday, :string
      add :description, :text
      add :avatar, :string
      add :token, :string
      add :search, :text
      add :status, :string

      timestamps
    end

  end
end
