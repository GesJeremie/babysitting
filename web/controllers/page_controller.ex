defmodule Babysitting.PageController do
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Helpers.App
  alias Babysitting.Offer

  def home(conn, _params) do
    tenant = App.current_tenant(conn)
    offers = Offer 
    |> Offer.from_current_tenant(conn)
    |> Repo.all

    render conn, "home.html", %{
      tenant: tenant,
      offers: offers
    }
  end
end
