defmodule Babysitting.DashboardAdmin.AuthController do
  use Babysitting.Web, :controller
  
  @password_login "babysittingrocks"

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, %{"login" => %{"password" => password}}) do
    
    conn = conn |> fetch_session

    count_attempt_login = conn |> get_session(:count_attempt_login) || 1

    if count_attempt_login <= 10 do

      if @password_login == password do
        conn
          |> put_session(:is_admin, true)
          |> delete_session(:count_attempt_login)
          |> redirect(to: "/dashboard")
      else
        conn
          |> put_session(:count_attempt_login, count_attempt_login + 1)
          |> put_flash(:error, "Impossible to connect with this password")
          |> redirect(to: "/dashboard/auth")
      end

    else 
      conn
        |> redirect(to: "/")
    end

  end

  def logout(conn, _params) do
    conn
      |> fetch_session
      |> delete_session(:is_admin)
      |> redirect(to: "/")
  end

end

