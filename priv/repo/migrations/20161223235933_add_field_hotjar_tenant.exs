defmodule Babysitting.Repo.Migrations.AddFieldHotjarTenant do
  use Ecto.Migration
  import Ecto.Query
  alias Babysitting.{Tenant, Repo}

  def change do

    alter table(:tenants) do
      add :hotjar, :string
    end

  end

end
