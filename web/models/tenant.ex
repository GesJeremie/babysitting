defmodule Babysitting.Tenant do
  use Babysitting.Web, :model

  schema "tenants" do
    field :name, :string
    field :domain, :string
    field :slug, :string
    field :facebook, :string
    timestamps
  end

  @required_fields ~w(name domain slug)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
