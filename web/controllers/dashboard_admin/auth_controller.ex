defmodule Babysitting.DashboardAdmin.AuthController do
  
  # Use
  use Babysitting.Web, :controller
  
  # Module attributes
  @password_login "babysittingrocks"

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
    case do
      count_do_login(conn) <= 10 ->
        conn
          |> do_login(password)
      _ ->
        conn
          |> redirect(to: app_page_path(conn, :home))
    end
  end

  @doc """
  Return the number of times the admin tried to login
  """
  defp count_do_login(conn) do
    (conn |> fetch_session |> get_session(:count_attempt_login)) || 1
  end

  @doc """
  Login the user if right password provided
  """
  defp do_login(conn, password) when password == @password_login do
      conn
        |> put_session(:is_admin, true)
        |> delete_session(:count_do_login)
        |> redirect(to: admin_analytics_path(conn, :index))
  end

  @doc """
  Doesn't login the user ann keep in memory the attempt
  """
  defp do_login(conn, _) do
    conn
      |> put_session(:count_do_login, count_do_login(conn) + 1)
      |> put_flash(:error, "Impossible to connect with this password")
      |> redirect(to: admin_auth_path(conn, :index))
  end

  @doc """
  Logout the user
  """
  def logout(conn, _params) do
    conn
      |> fetch_session
      |> delete_session(:is_admin)
      |> redirect(to: "/")
  end

end

