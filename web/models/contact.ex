defmodule Babysitting.Contact do
  use Babysitting.Web, :model

  schema "contacts" do
    field :tenant_id, :integer
    field :email, :string
    field :message, :string

    timestamps
  end

  @required_fields ~w(tenant_id email message)
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
