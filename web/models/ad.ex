defmodule Babysitting.Ad do
  use Babysitting.Web, :model
  use Arc.Ecto.Model
  alias Babysitting.Helpers.App

  schema "ads" do
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    field :password, :string
    field :phone, :string
    field :birthday, :string
    field :description, :string
    field :avatar, Babysitting.Avatar.Type
    field :token, :string
    field :search, :string
    field :status, :boolean, default: true
    field :valid, :boolean, default: false

    timestamps

    field :password_confirmation, :string, virtual: true

    # Relations
    belongs_to :tenant, Babysitting.Tenant
    has_many :ad_contacts, Babysitting.AdContact

  end

  @required_fields ~w(firstname lastname email password password_confirmation phone birthday description)
  @optional_fields ~w()

  @required_file_fields ~w(avatar)
  @optional_file_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
  end

  def create_changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
    |> validate_length(:description, min: 280)
    |> validate_format(:email, ~r/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> hash_password
    |> make_token
    |> make_search
  end

  @doc """
  Crypt the password given by the user
  """
  def hash_password(changeset) do
    changeset
    |> update_change(:password, &Comeonin.Bcrypt.hashpwsalt/1)
  end

  @doc """
  Generate an unique token for the offer
  """
  def make_token(changeset) do
    changeset
    |> put_change(:token, UUID.uuid1())
  end


  @doc """
  Generate a string "search" as keywords to avoid useless "join" in the future
  """
  def make_search(changeset) do
    with {:ok, firstname} <- fetch_change(changeset, :firstname),
         {:ok, lastname} <- fetch_change(changeset, :lastname),
         {:ok, description} <- fetch_change(changeset, :description) do
      put_change(changeset, :search, firstname <> " " <> lastname <> " " <> description)
    else
      :error ->
        changeset
    end
  end

  @doc """
  Filter offer by the current tenant
  """
  def from_current_tenant(query, conn) do
    from offer in query,
      where: offer.tenant_id == ^App.current_tenant(conn).id
  end

end
