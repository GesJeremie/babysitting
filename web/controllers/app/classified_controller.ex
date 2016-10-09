defmodule Babysitting.App.ClassifiedController do

  # Use
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.{Classified, ClassifiedContact}
  alias Babysitting.Helpers.{App, Ifttt, Format}
  alias Babysitting.{Email, Mailer}

  # Plugs
  plug :scrub_params, "classified" when action in [:create, :update]
  plug :scrub_params, "classified_contact" when action in [:create_contact]

  @doc """
  Display the form to create a new classified
  """
  def new(conn, _params) do
    conn
    |> render("new.html", changeset: Classified.changeset(%Classified{}))
  end

  def create_contact(conn, %{"classified_contact" => contact_params, "id" => id}) do
    
    # Fill params with classified id
    contact_params = set_classified(id, contact_params)
    
    changeset = ClassifiedContact.create_changeset(%ClassifiedContact{}, contact_params)

    case Repo.insert(changeset) do
      {:ok, contact} ->

        # Let's load associations
        contact = 
          contact
          |> Repo.preload(:classified)
          |> Repo.preload(classified: :tenant)

        conn
        |> put_flash(:info, gettext("Message sent!"))
        |> send_email(:new_contact_admin, contact)
        |> send_email(:new_contact, contact)
        |> redirect(to: app_classified_path(conn, :show, id))
      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Oops, some errors are present in the form."))
        |> show(%{"id" => id, "changeset" => changeset})
    end
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

        classified =
          classified |> Repo.preload(:tenant)

        conn
        |> trigger_success_events(classified)
        |> send_email(:new_classified_admin, classified)
        |> put_flash(:info, gettext("Classifed created successfully."))
        |> redirect(to: app_classified_path(conn, :thankyou))

      {:error, changeset} ->
        conn
        |> trigger_error_events(changeset)
        |> put_flash(:error, gettext("Oops, some errors are present in the form."))
        |> render("new.html", changeset: changeset)
    end
  end

  @doc """
  Show classified by the given id
  """
  def show(conn, params) do
    classified = Repo.get!(Classified, Map.get(params, "id"))

    changeset = 
      if Map.has_key?(params, "changeset") do
        Map.get(params, "changeset")
      else
        ClassifiedContact.changeset(%ClassifiedContact{})
      end

    conn
    |> render("show.html", classified: classified, changeset: changeset)
  end
  


  @doc """
  Display thank you page
  """
  def thankyou(conn, _params) do
    conn
      |> render("thankyou.html", %{current_tenant: App.current_tenant(conn)})
  end

  ###
  # Trigger success events to third parties
  ###
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

  ###
  # Trigger error events to third parties
  ###
  defp trigger_error_events(conn, changeset) do
    Keenex.add_event("classified.new", %{type: "failed", classified: changeset.changes, tenant: App.current_tenant(conn).name})
    conn
  end

  ###
  # Set the current tenant to the params
  ###
  defp set_current_tenant(conn, params) do
    current_tenant = App.current_tenant(conn)
    params
    |> Map.put("tenant_id", current_tenant.id)
  end

  ###
  # Set the classified id to the params struct
  ###
  defp set_classified(id, params) do
    params
    |> Map.put("classified_id", id)
  end

  ###
  # Alert the admin to validate the classified just added
  ###
  defp send_email(conn, :new_classified_admin, classified) do
    Email.new_classified_admin(%{conn: conn, classified: classified}) |> Mailer.deliver_later
    conn
  end

  ###
  # Send the message of the family to the baby sitter
  ###
  defp send_email(conn, :new_contact, contact) do
    %{conn: conn, contact: contact}
    |> Email.new_contact
    |> Mailer.deliver_later

    conn
  end

  ###
  # Alert the admin we just made a relation between 
  # a family and a baby sitter
  ###
  defp send_email(conn, :new_contact_admin, contact) do
    %{conn: conn, contact: contact}
    |> Email.new_contact_admin
    |> Mailer.deliver_later

    conn
  end

end
