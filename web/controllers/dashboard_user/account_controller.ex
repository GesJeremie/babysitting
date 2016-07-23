defmodule Babysitting.DashboardUser.AccountController do
  use Babysitting.Web, :controller
  alias Babysitting.Ad
  alias Babysitting.Helpers.App

  plug Babysitting.Plug.IsUser


  def index(conn, _) do
    ad = App.current_user(conn)
    render conn, "index.html", %{ad: ad}
  end
end