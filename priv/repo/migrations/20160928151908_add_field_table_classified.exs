defmodule Babysitting.Repo.Migrations.AddFieldTableClassified do
  use Ecto.Migration

  def change do
    alter table(:classifieds) do
      add :slug, :string
    end
  end
end
