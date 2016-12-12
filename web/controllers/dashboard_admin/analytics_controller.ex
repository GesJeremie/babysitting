defmodule Babysitting.DashboardAdmin.AnalyticsController do

  # Uses
  use Babysitting.Web, :controller

  # Plugs
  plug Babysitting.Plug.IsAdmin

  def index(conn, _params) do
    render conn, "index.html"
  end


end
