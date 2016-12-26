defmodule Babysitting.DashboardAdmin.ClassifiedController do
  # Uses
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Classified
  alias Babysitting.{Email, Mailer}
  alias Babysitting.Helpers.{App, Zapier}

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
  Delete the classified given
  """
  def delete(conn, %{"id" => id}) do

    Classified
    |> Repo.get!(id)
    |> Classified.delete_pictures
    |> Repo.delete!

    conn
    |> put_flash(:info, "Classified deleted")
    |> redirect(to: admin_classified_path(conn, :index))
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
          |> maybe_post_on_facebook(classified)
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

  defp maybe_post_on_facebook(conn, classified) do
    if Mix.env == :prod && classified.posted_on_facebook == false do
      do_post_on_facebook(conn, classified)
    end

    conn
  end

  ###
  # Note: Currently we are using Zapier and we are limited
  # by 100 tasks / month. That means we can only post 100
  # post per month. We don't really care yet, still we will have
  # to switch to IFTTT (but bad support for emojis and url description)
  # or code our thing with the API of facebook (what a nightmare...)
  ###
  defp do_post_on_facebook(conn, classified) do
    # Get url to post
    segment = Babysitting.Router.Helpers.app_classified_path(conn, :show, classified)
    url = App.current_tenant_url(conn, segment)

    # Get message to post
    emoji = Enum.random(["😇", "😃", "😁", "😍👍", "💪😉"])
    message = "#{gettext("A new baby sitter is available")} #{emoji}"

    # Get fan page id to post
    facebook_page_id = App.current_tenant_facebook_page_id(conn)

    # Send Zapier request
    Zapier.post_new_classified_on_facebook([url: url, message: message, facebook_page_id: facebook_page_id])

    # Update posted on facebook for the current classified to true
    classified
    |> Classified.update_admin_changeset(%{posted_on_facebook: true})
    |> Repo.update!

    conn
  end

end
