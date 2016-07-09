defmodule Babysitting.DashboardAdmin.AdController do
  use Babysitting.Web, :controller

  alias Babysitting.Ad

  plug :put_layout, "dashboard_admin.html"

  def index(conn, params) do

    state = Dict.get(params, "state")

    ads = Ad

    ads = case state do 
      "valid" -> ads |> Ad.valid
      "invalid" -> ads |> Ad.invalid
      _ -> ads
    end
    
    ads = ads
      |> Repo.all
      |> Repo.preload :tenant


    render(conn, "index.html", %{ads: ads})
  end

end
