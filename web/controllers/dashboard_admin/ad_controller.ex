defmodule Babysitting.DashboardAdmin.AdController do
  use Babysitting.Web, :controller

  alias Babysitting.Ad

  plug :put_layout, "dashboard_admin.html"
  plug Babysitting.Plug.IsAdmin

  def index(conn, params) do

    state = Dict.get(params, "state")

    ads = Ad
      |> Ad.filter_by_state(state)
      |> Repo.all
      |> Repo.preload(:tenant)

    render(conn, "index.html", %{ads: ads})
  end

  def validate(conn, %{"id" => id}) do
    ad = Repo.get!(Ad, id)
    ad_changed = %{ad | valid: true}

    case Repo.update(ad_changed) do
      {:ok, ad} ->
        conn
        |> put_flash(:info, "Ad validated successfully.")
        |> redirect(to: ad_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Impossible to validate the ad.")
        |> redirect(to: ad_path(conn, :index))
    end


  end

  def invalidate(conn, %{"id" => id}) do
    ad = Repo.get!(Ad, id)
    ad_changed = %{ad | valid: false}

    case Repo.update(ad_changed) do
      {:ok, ad} ->
        conn
        |> put_flash(:info, "Ad invalidated successfully.")
        |> redirect(to: ad_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Impossible to invalidate the ad.")
        |> redirect(to: ad_path(conn, :index))
    end
  end

end
