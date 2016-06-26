defmodule Babysitting.Offer do
  use Babysitting.Web, :model
  alias Babysitting.Helpers.App

  schema "offers" do
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    field :password, :string
    field :phone, :string
    field :birthday, :string
    field :description, :string
    field :avatar, :string
    field :token, :string
    field :search, :string
    field :status, :string

    timestamps

    field :password_confirmation, :string, virtual: true

    # Relations
    belongs_to :tenant, Babysitting.Tenant
    has_many :offer_contacts, Babysitting.OfferContact
    has_many :offer_hits, Babysitting.OfferHit

  end

  @required_fields ~w(firstname lastname email password password_confirmation phone birthday description avatar token search status)
  @optional_fields ~w()

  def create_changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:description, min: 280)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
  end

  @doc """
  Filter offer by the current tenant
  """
  def from_current_tenant(query, conn) do
    from offer in query,
      where: offer.tenant_id == ^App.current_tenant(conn).id
  end

end
