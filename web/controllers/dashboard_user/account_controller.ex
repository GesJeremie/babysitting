defmodule Babysitting.DashboardUser.AccountController do

  # Use
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Ad
  alias Babysitting.Helpers.App

  # Plugs
  plug Babysitting.Plug.IsUser

  @doc """
  Display the account's details of the user
  """
  def index(conn, _) do
    ad = App.current_user(conn)
    render conn, "index.html", %{ad: ad}
  end
end