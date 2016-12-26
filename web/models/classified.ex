defmodule Babysitting.Classified do
  use Babysitting.Web, :model
  use Arc.Ecto.Model
  alias Babysitting.Repo
  alias Babysitting.Helpers.{AppHelper}

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
    field :posted_on_facebook, :boolean, default: false

    timestamps

    field :password_confirmation, :string, virtual: true
    field :password_old, :string, virtual: true

    # Relations
    belongs_to :tenant, Babysitting.Tenant
    has_many :classified_contacts, Babysitting.ClassifiedContact, on_delete: :delete_all
  end

  def delete_pictures(classified) do
    pictures = Babysitting.Avatar.urls({classified.avatar, classified})

    pictures
    |> Enum.map(fn(picture) ->
      picture
      |> elem(1)
      |> String.split("?v=") # Remove fingerprint
      |> Enum.at(0)
      |> File.rm
    end)

    classified
  end

  @doc """
  Filter classified by the current tenant
  """
  def of_current_tenant(query, conn) do
    from classified in query,
      where: classified.tenant_id == ^AppHelper.current_tenant(conn).id
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
  Check if the query executed returned a result
  """
  def exists?([]), do: false
  def exists?(_), do: true

end
