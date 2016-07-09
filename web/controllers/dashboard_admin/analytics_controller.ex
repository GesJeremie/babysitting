defmodule Babysitting.DashboardAdmin.AnalyticsController do
  use Babysitting.Web, :controller
  alias Babysitting.Ad

  def index(conn, _params) do
    text conn, "AnalyticsController"
  end


end
