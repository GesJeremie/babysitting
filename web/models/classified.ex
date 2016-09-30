defmodule Babysitting.Classified do
  use Babysitting.Web, :model
  use Arc.Ecto.Model
  use Timex
  alias Babysitting.Helpers.App

  schema "classifieds" do
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
    has_many :classified_contacts, Babysitting.ClassifiedContact
  end

  @rules_create %{
    :required_fields => ~w(tenant_id firstname lastname email password password_confirmation phone birthday description),
    :optional_fields => ~w(),
    :required_files => ~w(avatar),
    :optional_files => ~w()
  }

  @rules_update %{
    :required_fields => ~w(firstname lastname email phone birthday description),
    :optional_fields => ~w(valid),
    :required_files => ~w(),
    :optional_files => ~w(avatar)
  }

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [], [])
  end

  @doc """
  Changeset when you create a new classified
  """
  def create_changeset(model, params \\ %{}) do
    model
    |> cast(params, @rules_create.required_fields, @rules_create.optional_fields)
    |> cast_attachments(params, @rules_create.required_files, @rules_create.optional_files)
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
  Changeset when you update an classified
  """
  def update_changeset(model, params \\ %{}) do
    model
    |> cast(params, @rules_update.required_fields, @rules_update.optional_fields)
    |> cast_attachments(params, @rules_update.required_files, @rules_create.optional_files)
    |> validate_length(:description, min: 280)
    |> validate_format(:email, ~r/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/)
    |> validate_format(:birthday, ~r/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/)
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
  Filter classified by the current tenant
  """
  def of_current_tenant(query, conn) do
    from classified in query,
      where: classified.tenant_id == ^App.current_tenant(conn).id
  end

  @doc """
  Filter classified by the state provided
  """
  def filter_by_state(query, "valid"), do: valid(query)
  def filter_by_state(query, "invalid"), do: invalid(query)
  def filter_by_state(query, "waiting"), do: waiting(query)
  def filter_by_state(query, _), do: query

  @doc """
  Filter classified not validated
  """
  def invalid(query) do
    from classified in query,
      where: classified.valid == false
  end

  @doc """
  Filter classified validated
  """
  def valid(query) do
    from classified in query,
      where: classified.valid == true
  end

  @doc """
  Filter classified waiting for validation
  """
  def waiting(query) do
    from classified in query,
      where: is_nil(classified.valid)
  end

  @doc """
  Filter classified inactive
  """
  def inactive(query) do
    from classified in query,
      where: classified.status == false
  end

  @doc """
  Filter classified active
  """
  def active(query) do
    from classified in query,
      where: classified.status == true
  end

  @doc """
  Sort the classified by recent
  """
  def sort_by_recent(query) do
    from classified in query,
      order_by: [desc: classified.inserted_at]
  end

  @doc """
  Global where filter
  """
  def where(query, field, condition) do
    from classified in query,
      where: field(classified, ^field) == ^condition
  end

  @doc """
  Check if the query executed returned no result or not
  """
  def exists?([]), do: false
  def exists?(_), do: true


end
