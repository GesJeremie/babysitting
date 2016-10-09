defmodule Babysitting.DashboardUser.SecurityController do
  use Babysitting.Web, :controller
  alias Babysitting.Classified
  alias Babysitting.Helpers.App
  
  plug :scrub_params, "security" when action in [:update_password]

  def index(conn, _) do
    conn
    |> redirect(to: user_security_path(conn, :password))
  end

  def password(conn, _params) do
    conn
    |> render("password.html", %{})
  end

  def update_password(conn, params) do
    IO.inspect params
    conn
    |> text "update password"
  end


end