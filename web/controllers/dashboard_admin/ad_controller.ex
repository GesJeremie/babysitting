defmodule Babysitting.DashboardAdmin.AdController do

  # Use
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Ad

  # Plugs
  plug Babysitting.Plug.IsAdmin

  @doc """
  Display the ads
  """
  def index(conn, params) do

    state = Map.get(params, "state")

    ads = Ad
      |> Ad.filter_by_state(state)
      |> Repo.all
      |> Repo.preload(:tenant)

    render(conn, "index.html", %{ads: ads, state: state})
  end

  @doc """
  Display a specific ad
  """
  def show(conn, %{"id" => id}) do
    ad = Ad 
      |> Repo.get!(id)
      |> Repo.preload(:tenant)
      
    render conn, "show.html", %{ad: ad}
  end

  @doc """
  Display a form to edit a specific ad
  """
  def edit(conn, %{"id" => id}) do
    ad = Ad
      |> Repo.get!(id)

    render conn, "edit.html", %{ad: ad, changeset: Ad.changeset(ad)}
  end

  @doc """
  Validate the ad given
  """
  def validate(conn, %{"id" => id}) do
    ad = Repo.get!(Ad, id)
    ad = %{ad | valid: true}

    case Repo.update(ad) do
      {:ok, ad} ->
        conn
        |> put_flash(:info, "Ad validated successfully.")
        |> redirect(to: admin_ad_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Impossible to validate the ad.")
        |> redirect(to: admin_ad_path(conn, :index))
    end
  end

  @doc """
  Invalidate the ad given
  """
  def invalidate(conn, %{"id" => id}) do
    ad = Repo.get!(Ad, id)
    ad = %{ad | valid: false}

    case Repo.update(ad) do
      {:ok, ad} ->
        conn
        |> put_flash(:info, "Ad invalidated successfully.")
        |> redirect(to: admin_ad_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Impossible to invalidate the ad.")
        |> redirect(to: admin_ad_path(conn, :index))
    end
  end

end
