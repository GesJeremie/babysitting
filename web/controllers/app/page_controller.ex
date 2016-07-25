defmodule Babysitting.App.PageController do
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Helpers.App
  alias Babysitting.Ad

  @doc """
  Display the home page with the ads of 
  the current tenant
  """
  def home(conn, _params) do
    tenant = App.current_tenant(conn)
    ads = fetch_ads(conn)

    render conn, "home.html", %{
      tenant: tenant,
      ads: ads
    }
  end

  def about(conn, _params) do
    render conn, "about.html", %{}
  end

  def legal(conn, _params) do
    render conn, "legal.html", %{}
  end

  def contact(conn, _params) do
    render conn, "contact.html", %{}
  end

  def press(conn, _params) do
    render conn, "press.html", %{}
  end

  def faq(conn, _params) do
    render conn, "faq.html", %{}
  end

  defp fetch_ads(conn) do
    Ad 
      |> Ad.of_current_tenant(conn)
      |> Ad.valid
      |> Ad.active
      |> Repo.all
  end
end
