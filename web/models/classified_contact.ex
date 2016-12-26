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

end
