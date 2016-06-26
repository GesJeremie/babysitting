defmodule Babysitting.OfferHit do
  use Babysitting.Web, :model

  schema "offer_hits" do
    field :ip, :string

    timestamps

    # Relations
    belongs_to :offer, Babysitting.Offer

  end

  @required_fields ~w(offer_id ip)
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
