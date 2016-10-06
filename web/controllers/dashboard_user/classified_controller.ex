defmodule Babysitting.DashboardUser.ClassifiedController do

  # Use
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Classified
  alias Babysitting.{Email, Mailer}
  alias Babysitting.Helpers.App

  # Plugs
  plug Babysitting.Plug.IsUser

  plug :scrub_params, "classified" when action in [:update]


  def index(conn, _) do
    conn
    |> redirect(to: user_classified_path(conn, :show))
  end
  
  @doc """
  Display the classified of the user
  """
  def show(conn, _) do
    classified = App.current_user(conn)
    changeset = Classified.changeset(classified)

    render conn, "show.html", %{classified: classified, changeset: changeset}
  end

  @doc """
  Update the classified
  """
  def update(conn, %{"classified" => classified_params}) do

    classified = App.current_user(conn)
    changeset = Classified.update_changeset(classified, classified_params)

    case Repo.update(changeset) do
      {:ok, classified} ->
        
        # Load tenant association
        classified = Repo.preload(classified, :tenant)

        conn
          |> send_email(:update_classified_admin, classified)
          |> put_flash(:info, gettext("Classified updated"))
          |> put_flash(:warning, gettext("Since you updated your classified, we put it back in queue for validation by our team"))
          |> redirect(to: user_classified_path(conn, :show))
      {:error, changeset} ->
        conn
          |> put_flash(:error, "Some errors are present in the form")
          |> render("show.html", %{classified: classified, changeset: changeset})
    end
  end

  ###
  # Alert the admin to validate the classified just updated
  ###
  defp send_email(conn, :update_classified_admin, classified) do
    Email.update_classified_admin(%{conn: conn, classified: classified}) |> Mailer.deliver_later
    conn
  end

end
