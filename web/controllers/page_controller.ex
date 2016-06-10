defmodule Babysitting.PageController do
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Helpers.App
  alias Babysitting.Offer

  def home(conn, _params) do
    
    town = App.host(conn)
    offers = Repo.all(Offer)

    render conn, "home.html", %{
      town: town,
      offers: offers
    }
  end
end
