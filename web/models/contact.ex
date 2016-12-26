defmodule Babysitting.Contact do
  use Babysitting.Web, :model

  schema "contacts" do
    field :email, :string
    field :message, :string

    timestamps

    belongs_to :tenant, Babysitting.Tenant

  end

end
