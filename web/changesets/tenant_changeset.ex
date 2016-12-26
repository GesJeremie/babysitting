defmodule Babysitting.Changesets.TenantChangeset do
  use Babysitting.Web, :changeset

  def default(model, params \\ %{}) do
    model
    |> cast(params, ~w(name domain slug facebook locale), ~w())
  end
end
