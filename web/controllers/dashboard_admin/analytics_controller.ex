defmodule Babysitting.DashboardAdmin.AnalyticsController do
  
  # Use
  use Babysitting.Web, :controller
  
  # PLug
  plug Babysitting.Plug.IsAdmin

  def index(conn, _params) do
    text conn, "AnalyticsController"
  end


end
