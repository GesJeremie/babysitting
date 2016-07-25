defmodule Babysitting.App.AdController do
  
  # Use
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Ad
  alias Babysitting.Helpers.{App, Ifttt, Mailer}

  # Plugs
  plug :scrub_params, "ad" when action in [:create, :update]

  @doc """
  Display the form to create a new ad
  """
  def new(conn, _params) do
    conn
      |> render("new.html", changeset: Ad.changeset(%Ad{}))
  end

  @doc """
  Commit the form given
  """
  def create(conn, %{"ad" => ad_params}) do

    # Fill params with current tenant
    ad_params = set_current_tenant(conn, ad_params)

    changeset = Ad.create_changeset(%Ad{}, ad_params)

    case Repo.insert(changeset) do
      {:ok, ad} ->
        conn
          |> trigger_success_events(ad)
          |> put_flash(:info, gettext "Ad created successfully.")
          |> redirect(to: app_ad_path(conn, :thankyou))

      {:error, changeset} ->
        conn
          |> trigger_error_events(changeset)
          |> render("new.html", changeset: changeset)
    end
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
  defp trigger_success_events(conn, ad) do

    # Fetch the current tenant
    current_tenant = App.current_tenant(conn)

    # Send events
    Ifttt.send_event("ad.new.created", Ad.fullname(ad), current_tenant.name)
    Keenex.add_event("ad.new", %{
      type: "created", 
      ad: %{id: ad.id, email: ad.email}, 
      tenant: %{id: current_tenant.id, name: current_tenant.name}
    })
    conn
  end

  @doc """
  Trigger error events to third parties
  """
  defp trigger_error_events(conn, changeset) do
    Keenex.add_event("ad.new", %{type: "failed", ad: changeset.changes, tenant: App.current_tenant(conn).name})
    conn
  end

  @doc """
  Set the current tenant to the paramss
  """
  defp set_current_tenant(conn, params) do
    current_tenant = App.current_tenant(conn)
    params 
      |> Map.put("tenant_id", current_tenant.id)
  end

end
