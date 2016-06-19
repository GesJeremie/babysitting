defmodule Babysitting.PageController do
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Helpers.App
  alias Babysitting.Offer

  def home(conn, _params) do
    tenant_name = App.current_tenant(conn).name
    offers = Offer 
    |> Offer.from_current_tenant(conn)
    |> Repo.all

    render conn, "home.html", %{
      tenant_name: tenant_name,
      offers: offers
    }
  end
end
