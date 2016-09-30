defmodule Babysitting.DashboardUser.ClassifiedController do

  # Use
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Classified
  alias Babysitting.Helpers.App

  # Plugs
  plug Babysitting.Plug.IsUser

  plug :scrub_params, "classified" when action in [:update]

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
    IO.inspect Map.get(classified_params, :avatar)
    case Repo.update(changeset) do
      {:ok, ad} ->
        conn
          |> put_flash(:info, "Classified updated")
          |> redirect(to: user_classified_path(conn, :show))
      {:error, changeset} ->
        conn
          |> put_flash(:error, "Some errors are present in the form")
          |> render "show.html", %{classified: classified, changeset: changeset}
    end
  end
end
