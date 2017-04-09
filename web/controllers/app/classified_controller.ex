defmodule Babysitting.App.ClassifiedController do
  # Uses
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.{Classified, ClassifiedContact}
  alias Babysitting.{Email, Mailer}
  alias Babysitting.Changesets.{ClassifiedChangeset, ClassifiedContactChangeset}
  alias Babysitting.Helpers.{AppHelper, StripeHelper}

  # Plugs
  plug :scrub_params, "classified" when action in [:create, :update]
  plug :scrub_params, "classified_contact" when action in [:create_contact]

  @doc """
  Display the form to create a new classified
  """
  def new(conn, _params) do
    conn
    |> render("new.html", changeset: ClassifiedChangeset.default(%Classified{}))
  end

  def create_contact(conn, %{"classified_contact" => contact_params, "id" => id}) do

    # Fill params with classified id
    contact_params = set_classified(id, contact_params)

    changeset = ClassifiedContactChangeset.create(%ClassifiedContact{}, contact_params)

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
  Commit the form to create a classfied
  """
  def create(conn, %{"classified" => classified_params}) do

    # Fill params with current tenant
    classified_params = set_current_tenant(conn, classified_params)

    changeset = ClassifiedChangeset.create(%Classified{}, classified_params)

    case Repo.insert(changeset) do
      {:ok, classified} ->

        case StripeHelper.maybe_charge_classified(classified, classified_params["stripe_token"], conn) do
          {:ok, :charge} ->
            classified = classified |> Repo.preload(:tenant)

            conn
            |> trigger_success_events(classified)
            |> send_email(:new_classified_admin, classified)
            |> put_flash(:info, gettext("Classifed created successfully."))
            |> redirect(to: app_classified_path(conn, :thankyou))

          {:error, :charge, message} ->

            # The charge failed, let's remove the classified from the db
            Repo.get(Classified, classified.id) |> Repo.delete

            conn
            |> put_flash(:error, message)
            |> render("new.html", changeset: changeset)
        end

      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Oops, some errors are present in the form."))
        |> render("new.html", changeset: changeset)
    end
  end

  @doc """
  Show classified by the given id
  """
  def show(conn, params) do
    classified =
      Classified
      |> Classified.of_current_tenant(conn)
      |> Classified.where(:id, Map.get(params, "id"))
      |> Repo.one!
      |> Repo.preload(:tenant)

    changeset =
      if Map.has_key?(params, "changeset") do
        Map.get(params, "changeset")
      else
        ClassifiedContactChangeset.default(%ClassifiedContact{})
      end

    conn
    |> render("show.html", classified: classified, changeset: changeset)
  end

  @doc """
  Display thank you page
  """
  def thankyou(conn, _params) do
    conn
    |> render("thankyou.html", %{current_tenant: AppHelper.current_tenant(conn)})
  end

  ###
  # Trigger success events to third parties
  ###
  defp trigger_success_events(conn, classified) do

    # Fetch the current tenant
    current_tenant = AppHelper.current_tenant(conn)

    # Nothing now. It was some events to keenex
    # but the package was buggy.

    conn
  end

  ###
  # Set the current tenant to the params
  ###
  defp set_current_tenant(conn, params) do
    current_tenant = AppHelper.current_tenant(conn)
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
