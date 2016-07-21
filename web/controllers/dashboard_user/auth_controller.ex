defmodule Babysitting.DashboardUser.AuthController do
  use Babysitting.Web, :controller
  alias Babysitting.Ad

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, %{"login" => %{"email" => email, "password" => password}}) do

    login = can_login_with?(email, password, conn)

    text conn, login

  end

  def logout(conn, _params) do
    conn
      |> fetch_session
      |> delete_session(:is_admin)
      |> redirect(to: "/")
  end

  defp can_login_with?(email, password, conn) do
    Ad
      |> Ad.of_current_tenant(conn)
      |> Ad.where(:email, email)
      |> Ad.where(:password, password)
      |> Repo.all
      |> Ad.exists?
  end

end

