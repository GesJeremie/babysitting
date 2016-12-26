defmodule Babysitting.Changesets.ContactChangeset do
  use Babysitting.Web, :changeset

  def default(model, params \\ %{}) do
    model
    |> cast(params, ~w(email message), ~w())
  end
end
