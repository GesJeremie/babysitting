defmodule Babysitting.Tenant do
  use Babysitting.Web, :model

  schema "tenants" do
    field :name, :string
    field :domain, :string
    field :slug, :string
    field :facebook, :string
    field :locale, :string
    field :hotjar, :string
    field :google_analytics, :string

    timestamps

    has_many :classifieds, Babysitting.Classified, on_delete: :delete_all
    has_many :contacts, Babysitting.Contact, on_delete: :delete_all
  end

end
