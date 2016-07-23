defmodule Babysitting.App.AdController do
  use Babysitting.Web, :controller

  alias Babysitting.Ad
  alias Babysitting.Helpers.{App, Ifttt, Mailer}

  plug :scrub_params, "ad" when action in [:create, :update]

  @doc """
  Display the form to create a new ad
  """
  def new(conn, _params) do
    changeset = Ad.changeset(%Ad{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  Commit the form given
  """
  def create(conn, %{"ad" => ad_params}) do

    ad_params = set_current_tenant(conn, ad_params)

    changeset = Ad.create_changeset(%Ad{}, ad_params)

    case Repo.insert(changeset) do
      {:ok, ad} ->

        # Trigger some events
        Ifttt.send_event("ad.new.created", Ad.fullname(ad), current_tenant.name)
        Keenex.add_event("ad.new", %{type: "created", ad: %{id: ad.id, email: ad.email}, tenant: %{id: current_tenant.id, name: current_tenant.name}})

        conn
        |> put_flash(:info, gettext "Ad created successfully.")
        |> redirect(to: app_ad_path(conn, :thankyou))

      {:error, changeset} ->

        Keenex.add_event("ad.new", %{type: "failed", ad: changeset.changes, tenant: App.current_tenant(conn).name})

        render(conn, "new.html", changeset: changeset)
    end
  end


  def thankyou(conn, _params) do

    current_tenant = App.current_tenant(conn)

    render conn, "thankyou.html", %{current_tenant: current_tenant}
  end

  defp trigger_events do
    
  end

  defp set_current_tenant(conn, params) do
    current_tenant = App.current_tenant(conn)
    params 
      |> Map.put("tenant_id", current_tenant.id)
  end

  """
  def show(conn, %{"id" => id}) do
    offer = Repo.get!(Offer, id)
    render(conn, "show.html", offer: offer)
  end

  def edit(conn, %{"id" => id}) do
    offer = Repo.get!(Offer, id)
    changeset = Offer.changeset(offer)
    render(conn, "edit.html", offer: offer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "offer" => offer_params}) do
    offer = Repo.get!(Offer, id)
    changeset = Offer.changeset(offer, offer_params)

    case Repo.update(changeset) do
      {:ok, offer} ->
        conn
        |> put_flash(:info, "Offer updated successfully.")
        |> redirect(to: offer_path(conn, :show, offer))
      {:error, changeset} ->
        render(conn, "edit.html", offer: offer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    offer = Repo.get!(Offer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(offer)

    conn
    |> put_flash(:info, "Offer deleted successfully.")
    |> redirect(to: offer_path(conn, :index))
  end
  """

end
