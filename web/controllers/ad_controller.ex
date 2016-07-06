defmodule Babysitting.AdController do
  use Babysitting.Web, :controller

  alias Babysitting.Ad
  alias Babysitting.Helpers.App

  plug :scrub_params, "ad" when action in [:create, :update]

  def new(conn, _params) do
    changeset = Ad.changeset(%Ad{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ad" => ad_params}) do

    # Fill the params with the current tenant id
    ad_params = ad_params |> Map.put("tenant_id", App.current_tenant(conn).id)

    changeset = Ad.create_changeset(%Ad{}, ad_params)

    case Repo.insert(changeset) do
      {:ok, _offer} ->
        conn
        |> put_flash(:info, gettext "Ad created successfully.")
        |> redirect(to: page_path(conn, :home))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
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
