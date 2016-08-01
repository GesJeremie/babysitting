defmodule Babysitting.Ad do
  use Babysitting.Web, :model
  use Arc.Ecto.Model
  use Timex
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
    field :valid, :boolean

    timestamps

    field :password_confirmation, :string, virtual: true

    # Relations
    belongs_to :tenant, Babysitting.Tenant
    has_many :ad_contacts, Babysitting.AdContact

  end

  @required_fields ~w(tenant_id firstname lastname email password password_confirmation phone birthday description)
  @optional_fields ~w()

  @required_file_fields ~w(avatar)
  @optional_file_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def create_changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_attachments(params, @required_file_fields, @optional_file_fields)
    |> validate_length(:description, min: 280)
    |> validate_format(:email, ~r/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/)
    |> validate_format(:birthday, ~r/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/)
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
  Filter ad by the current tenant
  """
  def of_current_tenant(query, conn) do
    from ad in query,
      where: ad.tenant_id == ^App.current_tenant(conn).id
  end

  @doc """
  Filter ad by the state provided
  """
  def filter_by_state(query, "valid"), do: valid(query)
  def filter_by_state(query, "invalid"), do: invalid(query)
  def filter_by_state(query, "waiting"), do: waiting(query)
  def filter_by_state(query, _), do: query

  @doc """
  Filter ad not validated
  """
  def invalid(query) do
    from ad in query,
      where: ad.valid == false
  end

  @doc """
  Filter ad validated
  """
  def valid(query) do
    from ad in query,
      where: ad.valid == true
  end

  @doc """
  Filter ad waiting for validation
  """
  def waiting(query) do
    from ad in query,
      where: is_nil(ad.valid)
  end

  @doc """
  Filter ad inactive
  """
  def inactive(query) do
    from ad in query,
      where: ad.status == false
  end

  @doc """
  Filter ad active
  """
  def active(query) do
    from ad in query,
      where: ad.status == true
  end

  @doc """
  Global where filter
  """
  def where(query, field, condition) do
    from ad in query,
      where: field(ad, ^field) == ^condition
  end

  @doc """
  Check if the query executed returned no result or not
  """
  def exists?([]), do: false
  def exists?(result), do: true 


end
