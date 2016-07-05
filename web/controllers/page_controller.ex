defmodule Babysitting.PageController do
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Helpers.App
  alias Babysitting.Ad

  def home(conn, _params) do
    tenant = App.current_tenant(conn)

    ads = Ad 
    |> Ad.from_current_tenant(conn)
    |> Repo.all

    render conn, "home.html", %{
      tenant: tenant,
      ads: ads
    }
  end
end
