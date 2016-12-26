defmodule Babysitting.Changesets.ClassifiedContactChangeset do
  use Babysitting.Web, :changeset

  def default(model, params \\ %{}) do
    model
    |> cast(params, ~w(email message phone classified_id), ~w())
  end

  def create(model, params \\ %{}) do
    model
    |> cast(params, ~w(email message phone classified_id), ~w())
    |> validate_format(:email, ~r/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/)
  end
end
