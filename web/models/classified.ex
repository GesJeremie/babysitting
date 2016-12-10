defmodule Babysitting.Classified do
  use Babysitting.Web, :model
  use Arc.Ecto.Model
  use Timex
  alias Babysitting.Repo
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
    field :password_old, :string, virtual: true

    # Relations
    belongs_to :tenant, Babysitting.Tenant
    has_many :classified_contacts, Babysitting.ClassifiedContact, on_delete: :delete_all
  end


  @valid_email ~r/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  @valid_birthday ~r/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/
  @min_length_description 280 
  @min_length_password 6

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [], [])
  end

  @doc """
  Changeset when you create a new classified
  """
  def create_changeset(model, params \\ %{}) do
    changeset = 
      model
      |> cast(params, ~w(tenant_id firstname lastname email password password_confirmation phone birthday description), [])
      |> validate_length(:description, min: @min_length_description)
      |> validate_format(:email, @valid_email)
      |> validate_format(:birthday, @valid_birthday)
      |> validate_length(:password, min: @min_length_password)
      |> validate_confirmation(:password)
      |> validate_unique_email
      |> hash_password
      |> make_token
      |> make_search

    if changeset.valid? do
      # Handle picture upload
      changeset
      |> cast_attachments(params, ~w(avatar), [])
    else
      changeset
    end

  end

  @doc """
  Changeset when an admin updates the classified
  """
  def update_admin_changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(firstname lastname email phone birthday description valid), ~w(valid))
    |> validate_length(:description, min: @min_length_description)
    |> validate_format(:email, @valid_email)
    |> validate_format(:birthday, @valid_birthday)
    |> validate_unique_email(model.id)
    |> make_search
  end

  @doc """
  Changeset when an user updates the classified
  """
  def update_changeset(model, params \\ %{}) do
    changeset = 
      model
      |> cast(params, ~w(firstname lastname email phone birthday description), ~w())
      |> validate_length(:description, min: @min_length_description)
      |> validate_format(:email, @valid_email)
      |> validate_format(:birthday, @valid_birthday)
      |> validate_unique_email(model.id)
      |> mark_as_invalid
      |> make_search
    
    if changeset.valid? do
      changeset 
      |> cast_attachments(params, ~w(), ~w(avatar))
    else
      changeset
    end

  end

  def update_password_changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(password password_confirmation password_old), ~w())
    |> validate_length(:password, min: @min_length_password)
    |> validate_confirmation(:password)
    |> validate_old_password
    |> hash_password
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
  Will check if the email is unique in the database
  """
  def validate_unique_email(changeset, id \\ nil) do
    email = fetch_field(changeset, :email)

    case email do

      {_type, nil} ->
        changeset

      {_type, email} ->
        
        query = Babysitting.Classified |> where(:email, email)

        unless is_nil(id) do
          query = query |> where_not(:id, id)
        end

        classifieds = Repo.all(query)

        if length(classifieds) > 0 do
          add_error(changeset, :email, "already taken")
        else 
          changeset
        end
      
      _ ->
        changeset
    end
  end

  def validate_old_password(changeset) do
    validate_change changeset, :password_old, fn _, password_old ->

      if Comeonin.Bcrypt.checkpw(password_old, changeset.data.password) do
        []
      else
        [password_old: "invalid password"]
      end
    end
  end

  @doc """
  Mark the classified as invalid
  """
  def mark_as_invalid(changeset) do
    changeset
    |> put_change(:valid, nil)  
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
  Global where not filter 
  """
  def where_not(query, field, condition) do
    from classified in query,
      where: field(classified, ^field) != ^condition
  end

  @doc """
  Check if the query executed returned no result or not
  """
  def exists?([]), do: false
  def exists?(_), do: true


end
