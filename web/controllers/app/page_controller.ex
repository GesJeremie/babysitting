defmodule Babysitting.App.PageController do
  # Uses
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.Helpers.{AppHelper}
  alias Babysitting.{Classified}

  @doc """
  Display the home page with the classifieds of
  the current tenant
  """
  def home(conn, params) do
    tenant = AppHelper.current_tenant(conn)
    classifieds = fetch_classifieds(conn, params)

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
