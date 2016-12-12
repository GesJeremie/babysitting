defmodule Babysitting.DashboardAdmin.AuthController do

  # Uses
  use Babysitting.Web, :controller

  # Attributes
  @password_login Application.get_env(:babysitting, :admin_password)

  @doc """
  Display the login form
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @doc """
  Try to login the user
  """
  def login(conn, %{"login" => %{"password" => password}}) do
    if count_do_login(conn) <= 10 do
      conn
        |> do_login(password)
    else
      conn
        |> redirect(to: app_page_path(conn, :home))
    end
  end

  @doc """
  Logout the user
  """
  def logout(conn, _params) do
    conn
      |> fetch_session
      |> delete_session(:is_admin)
      |> put_flash(:info, "You just signed out!")
      |> redirect(to: "/")
  end

  ###
  # Return the number of times the admin tried to login
  ###
  defp count_do_login(conn) do
    (conn |> fetch_session |> get_session(:count_attempt_login)) || 1
  end

  ###
  # Login the user if right password provided
  ###
  defp do_login(conn, password) when password == @password_login do
      conn
        |> put_session(:is_admin, true)
        |> put_flash(:info, "Welcome back admin!")
        |> delete_session(:count_do_login)
        |> redirect(to: admin_analytics_path(conn, :index))
  end

  ##
  # Don't login the user and keep in memory the attempt
  ##
  defp do_login(conn, _) do
    conn
      |> put_session(:count_do_login, count_do_login(conn) + 1)
      |> put_flash(:error, "Impossible to connect with this password")
      |> redirect(to: admin_auth_path(conn, :index))
  end

end
