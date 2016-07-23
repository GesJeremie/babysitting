defmodule Babysitting.DashboardUser.AuthController do
  use Babysitting.Web, :controller
  alias Babysitting.Ad

  @doc """
  Display form to login
  """
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @doc """
  Will try to login with the email / password combo given
  """
  def login(conn, %{"login" => %{"email" => email, "password" => password}}) do

    case can_login_with(email, password, conn) do 
      {:error} ->
        conn
          |> put_flash(:error, gettext("Unable to connect this email / password"))
          |> redirect(to: user_auth_path(conn, :index))
      {:ok, id} ->
        conn
          |> fetch_session
          |> put_session(:is_user, true)
          |> put_session(:current_user, id)
          |> redirect(to: user_auth_path(conn, :index))
    end

  end

  @doc """
  Will logout the user
  """
  def logout(conn, _params) do
    conn
      |> fetch_session
      |> delete_session(:is_user)
      |> delete_session(:current_user)
      |> redirect(to: app_page_path(conn, :home))
  end

  @doc """
  Check with the combo email / password given
  if it's possible to "connect"
  """
  defp can_login_with(email, password, conn) do
    Ad
      |> Ad.of_current_tenant(conn)
      |> Ad.where(:email, email)
      |> Repo.one
      |> case do
        nil -> {:error}
        ad -> check_password(password, ad)
      end
  end

  @doc """
  Check if we have a match between the password given by the user
  and the password stored in the database
  """
  defp check_password(password, ad) do
    case Comeonin.Bcrypt.checkpw(password, ad.password) do
      false -> {:error}
      true -> {:ok, ad.id}
    end
  end 


end