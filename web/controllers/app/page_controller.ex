defmodule Babysitting.App.PageController do
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Helpers.App
  alias Babysitting.Ad

  def home(conn, _params) do
    tenant = App.current_tenant(conn)

    ads = Ad 
    |> Ad.of_current_tenant(conn)
    |> Ad.valid
    |> Ad.active
    |> Repo.all

    IO.inspect ads

    render conn, "home.html", %{
      tenant: tenant,
      ads: ads
    }
  end
end
