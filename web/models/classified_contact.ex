defmodule Babysitting.ClassifiedContacts do
  use Babysitting.Web, :model

  schema "classified_contacts" do
    field :email, :string
    field :message, :string
    field :phone, :string

    timestamps

    # Relations
    belongs_to :classified, Babysitting.Classified
  end

  @required_fields ~w(email message phone)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
