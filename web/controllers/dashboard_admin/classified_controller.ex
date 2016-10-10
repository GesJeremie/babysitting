defmodule Babysitting.DashboardAdmin.ClassifiedController do

  # Use
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Classified
  alias Babysitting.{Email, Mailer}

  # Plugs
  plug Babysitting.Plug.IsAdmin
  plug :scrub_params, "classified" when action in [:update]

  @doc """
  Display the classifieds
  """
  def index(conn, params) do

    state = Map.get(params, "state")

    classifieds = Classified
      |> Classified.filter_by_state(state)
      |> Repo.all
      |> Repo.preload(:tenant)

    render(conn, "index.html", %{classifieds: classifieds, state: state})
  end

  @doc """
  Display a specific classified
  """
  def show(conn, %{"id" => id}) do
    classified = Classified
      |> Repo.get!(id)
      |> Repo.preload(:tenant)

    render conn, "show.html", %{classified: classified}
  end

  @doc """
  Display a form to edit a specific classified
  """
  def edit(conn, %{"id" => id}) do
    classified = Repo.get!(Classified, id)
    changeset = Classified.changeset(classified)
    render conn, "edit.html", %{classified: classified, changeset: changeset}
  end

  @doc """
  Update the classified
  """
  def update(conn, %{"id" => id, "classified" => classified_params}) do
    classified = Repo.get!(Classified, id)
    changeset = Classified.update_admin_changeset(classified, classified_params)
    case Repo.update(changeset) do
      {:ok, _classified} ->
        conn
          |> put_flash(:info, "Classified updated")
          |> redirect(to: admin_classified_path(conn, :edit, classified))
      {:error, changeset} ->
        conn
          |> put_flash(:error, "Some errors are present in the form")
          |> render("edit.html", %{classified: classified, changeset: changeset})
    end
  end

  @doc """
  Validate the classified given
  """
  def validate(conn, %{"id" => id}) do
    classified = Repo.get!(Classified, id)
    changeset = Classified.update_admin_changeset(classified, %{"valid" => true})

    case Repo.update(changeset) do
      {:ok, classified} ->
        conn
          |> send_email_validated(classified)
          |> put_flash(:info, "Classified validated!")
          |> redirect(to: admin_classified_path(conn, :index))
      {:error, _changeset} ->
        conn
          |> put_flash(:error, "Impossible to validate the classified.")
          |> redirect(to: admin_classified_path(conn, :index))
    end
  end

  @doc """
  Invalidate the classified given
  """
  def invalidate(conn, %{"id" => id}) do
    classified = Repo.get!(Classified, id)
    changeset = Classified.update_admin_changeset(classified, %{"valid" => false})

    case Repo.update(changeset) do
      {:ok, classified} ->
        conn
          |> send_email_rejected(classified)
          |> put_flash(:info, "Classified rejected!")
          |> redirect(to: admin_classified_path(conn, :index))
      {:error, _changeset} ->
        conn
          |> put_flash(:error, "Impossible to reject the classified.")
          |> redirect(to: admin_classified_path(conn, :index))
    end
  end

  defp send_email_validated(conn, classified) do
    classified = Repo.preload(classified, :tenant)

    Email.validated(%{conn: conn, classified: classified}) 
    |> Mailer.deliver_later

    conn
  end

  defp send_email_rejected(conn, classified) do
    classified = Repo.preload(classified, :tenant)

    Email.rejected(%{conn: conn, classified: classified}) 
    |> Mailer.deliver_later

    conn
  end

end
