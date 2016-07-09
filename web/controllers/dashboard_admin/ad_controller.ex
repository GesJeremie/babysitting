defmodule Babysitting.DashboardAdmin.AdController do
  use Babysitting.Web, :controller

  alias Babysitting.Ad

  plug :put_layout, "dashboard_admin.html"

  def index(conn, _params) do
    ads = Repo.all(Ad) |> Repo.preload :tenant

    IO.inspect ads
    render(conn, "index.html", %{ads: ads})
  end

end
