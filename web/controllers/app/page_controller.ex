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
    IO.inspect Path.expand('./uploads')
    render conn, "home.html", %{
      tenant: tenant,
      classifieds: classifieds
    }
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
