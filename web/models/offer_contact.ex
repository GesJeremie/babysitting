defmodule Babysitting.OfferContact do
  use Babysitting.Web, :model

  schema "offer_contacts" do
    field :email, :string
    field :message, :string
    field :phone, :string

    timestamps

    # Relations
    belongs_to :offer, Babysitting.Offer
  end

  @required_fields ~w(email message phone)
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
