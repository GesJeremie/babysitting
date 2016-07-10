defmodule Babysitting.DashboardAdmin.AnalyticsController do
  use Babysitting.Web, :controller
  
  plug Babysitting.Plug.IsAdmin

  def index(conn, _params) do
    text conn, "AnalyticsController"
  end


end
