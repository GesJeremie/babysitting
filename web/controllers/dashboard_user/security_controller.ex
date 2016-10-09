defmodule Babysitting.DashboardUser.SecurityController do
  use Babysitting.Web, :controller
  alias Babysitting.Classified
  alias Babysitting.Helpers.App
  
  plug :scrub_params, "classified" when action in [:update_password]

  def index(conn, _) do
    conn
    |> redirect(to: user_security_path(conn, :password))
  end

  def password(conn, _params) do

    classified = App.current_user(conn)
    changeset = Classified.changeset(classified)
    
    conn
    |> render("password.html", %{changeset: changeset})
  end

  def update_password(conn, %{"classified" => classified_params}) do
  
    classified = App.current_user(conn)
    changeset = Classified.update_password_changeset(classified, classified_params)

    case Repo.update(changeset) do
      {:ok, _classified} ->
        conn
          |> put_flash(:info, gettext("Password changed!"))
          |> redirect(to: user_security_path(conn, :password))
      {:error, changeset} ->
        conn
          |> put_flash(:error, "Some errors are present in the form")
          |> render("password.html", %{changeset: changeset})
    end
  end


end
