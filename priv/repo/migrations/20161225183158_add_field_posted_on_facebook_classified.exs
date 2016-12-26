defmodule Babysitting.Repo.Migrations.AddFieldPostedOnFacebookClassified do
  use Ecto.Migration

  def change do
    alter table(:classifieds) do
      add :posted_on_facebook, :boolean, default: false
    end
  end
end
