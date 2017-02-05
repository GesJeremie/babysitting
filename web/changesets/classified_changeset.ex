defmodule Babysitting.Changesets.ClassifiedChangeset do
  use Babysitting.Web, :changeset
  use Arc.Ecto.Model
  use Timex

  alias Babysitting.Repo

  import Babysitting.Gettext
  import Babysitting.Classified, only: [where_not: 3, where: 3]

  @valid_email ~r/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  @valid_birthday ~r/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/
  @min_length_description 280
  @min_length_password 6

  def default(model, params \\ %{}) do
    model
    |> cast(params, [], [])
  end

  @doc """
  Changeset when an user create a new classified
  """
  def create(model, params \\ %{}) do
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
  Changeset when a migration creates a classified
  """
  def create_by_migration(model, params \\ %{}) do
    changeset =
      model
      |> cast(params, ~w(tenant_id valid inserted_at posted_on_facebook firstname lastname email password phone birthday description))
      |> validate_required([:tenant_id, :valid, :inserted_at, :firstname, :lastname, :email, :password, :phone, :birthday, :description])
      |> validate_length(:description, min: @min_length_description)
      |> validate_format(:email, @valid_email)
      |> validate_format(:birthday, @valid_birthday)
      |> validate_length(:password, min: @min_length_password)
      |> validate_unique_email
      |> hash_password
      |> make_token
      |> make_search

    if changeset.valid? do
      changeset
      |> cast_attachments(params, ~w(avatar), [])
    else
      changeset
    end

  end

  @doc """
  Changeset when an user updates the classified
  """
  def update(model, params \\ %{}) do
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

  def update_password(model, params \\ %{}) do
    model
    |> cast(params, ~w(password password_confirmation password_old), ~w())
    |> validate_length(:password, min: @min_length_password)
    |> validate_confirmation(:password)
    |> validate_old_password
    |> hash_password
  end

  @doc """
  Changeset when an admin updates the classified
  """
  def update_by_admin(model, params \\ %{}) do
    model
    |> cast(params, ~w(firstname lastname email phone birthday description valid), ~w(valid posted_on_facebook))
    |> validate_length(:description, min: @min_length_description)
    |> validate_format(:email, @valid_email)
    |> validate_format(:birthday, @valid_birthday)
    |> validate_unique_email(model.id)
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
  Mark the classified as invalid
  """
  def mark_as_invalid(changeset) do
    changeset
    |> put_change(:valid, nil)
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
          add_error(changeset, :email, gettext("already taken"))
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

end
