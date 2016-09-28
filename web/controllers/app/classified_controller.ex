defmodule Babysitting.App.ClassifiedController do

  # Use
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Classified
  alias Babysitting.Helpers.{App, Ifttt, Mailer, Format}

  # Plugs
  plug :scrub_params, "classified" when action in [:create, :update]

  @doc """
  Display the form to create a new classified
  """
  def new(conn, _params) do
    conn
      |> render("new.html", changeset: Classified.changeset(%Classified{}))
  end

  @doc """
  Commit the form given
  """
  def create(conn, %{"classified" => classified_params}) do

    # Fill params with current tenant
    classified_params = set_current_tenant(conn, classified_params)

    changeset = Classified.create_changeset(%Classified{}, classified_params)

    case Repo.insert(changeset) do
      {:ok, classified} ->
        conn
          |> trigger_success_events(classified)
          |> put_flash(:info, gettext("Classifed created successfully."))
          |> redirect(to: app_classified_path(conn, :thankyou))

      {:error, changeset} ->
        conn
          |> trigger_error_events(changeset)
          |> put_flash(:error, gettext("Oops, some errors are present in the form."))
          |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    classified = Repo.get!(Classified, id)

    conn
    |> render("show.html", classified: classified)
  end

  @doc """
  Display thank you page
  """
  def thankyou(conn, _params) do
    conn
      |> render("thankyou.html", %{current_tenant: App.current_tenant(conn)})
  end

  @doc """
  Trigger success events to third parties
  """
  defp trigger_success_events(conn, classified) do

    # Fetch the current tenant
    current_tenant = App.current_tenant(conn)

    # Send events
    Ifttt.send_event("classified.new.created", Format.fullname(classified.firstname, classified.lastname), current_tenant.name)
    Keenex.add_event("classified.new", %{
      type: "created",
      classified: %{id: classified.id, email: classified.email},
      tenant: %{id: current_tenant.id, name: current_tenant.name}
    })
    conn
  end

  @doc """
  Trigger error events to third parties
  """
  defp trigger_error_events(conn, changeset) do
    Keenex.add_event("classified.new", %{type: "failed", classified: changeset.changes, tenant: App.current_tenant(conn).name})
    conn
  end

  @doc """
  Set the current tenant to the params
  """
  defp set_current_tenant(conn, params) do
    current_tenant = App.current_tenant(conn)
    params
      |> Map.put("tenant_id", current_tenant.id)
  end

end
