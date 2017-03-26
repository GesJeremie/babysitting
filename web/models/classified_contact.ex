defmodule Babysitting.ClassifiedContact do
  use Babysitting.Web, :model

  schema "classified_contacts" do
    field :email, :string
    field :message, :string
    field :phone, :string

    timestamps

    # Relations
    belongs_to :classified, Babysitting.Classified
  end

  @doc """
  Sort the messages by recent
  """
  def sort_by_recent(query) do
    from contact in query,
      order_by: [desc: contact.inserted_at]
  end

  @doc """
  Global where filter
  """
  def where(query, field, condition) do
    from contact in query,
      where: field(contact, ^field) == ^condition
  end
end
