defmodule Babysitting.Repo.Migrations.CreateClassifiedContact do
  use Ecto.Migration

  def change do
    create table(:classified_contacts) do
      add :classified_id, references(:classifieds)
      add :email, :string
      add :message, :text
      add :phone, :string

      timestamps
    end

  end
end
