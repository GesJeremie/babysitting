defmodule Babysitting.App.PageController do
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Helpers.App
  alias Babysitting.Classified

  @doc """
  Display the home page with the classifieds of
  the current tenant
  """
  def home(conn, params) do
    tenant = App.current_tenant(conn)
    classifieds = fetch_classifieds(conn, params)

    render conn, "home.html", %{
      tenant: tenant,
      classifieds: classifieds
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

  defp fetch_classifieds(conn, params) do
    Classified
      |> Classified.of_current_tenant(conn)
      |> Classified.valid
      |> Classified.active
      |> Classified.sort_by_recent
      |> Repo.paginate(params)
  end
end
