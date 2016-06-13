defmodule Babysitting.Offer do
  use Babysitting.Web, :model

  schema "offers" do
    field :tenant_id, :integer
    field :firstname, :string
    field :lastname, :string
    field :phone, :string
    field :day_birthday, :integer
    field :month_birthday, :string
    field :year_birthday, :string
    field :description, :string
    field :avatar, :string
    field :token, :string
    field :search, :string
    field :status, :string

    timestamps
  end

  @required_fields ~w(tenant_id firstname lastname phone day_birthday month_birthday year_birthday description avatar)
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
