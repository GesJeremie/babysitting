defmodule Babysitting.App.SitemapController do
  # Uses
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.{Classified, Repo}
  alias Babysitting.Helpers.App

  @doc """
  Used to generate the urls of the sitemap
  """
  @http_protocol "http://"

  @doc """
  Generate and render sitemap.xml
  """
  def index(conn, _params) do
    urls = sitemap_urls(conn)

    conn
    |> put_layout(false)
    |> put_resp_content_type("text/xml")
    |> render("index.html", [urls: urls])
  end

  ###
  # Fetch every urls to render in the sitemap
  ###
  defp sitemap_urls(conn) do
    classified_urls(conn) ++ page_urls(conn)
  end

  ###
  # Fetch every urls of the classifieds
  ###
  defp classified_urls(conn) do
    classifieds = fetch_classifieds(conn)

    for classified <- classifieds do
      segment = Babysitting.Router.Helpers.app_classified_path(conn, :show, classified)
      App.current_tenant_url(conn, segment)
    end
  end

  ###
  # Fetch every static pages of the scope "app"
  ###
  defp page_urls(conn) do
    pages = [:home]

    for page <- pages do
      segment = Babysitting.Router.Helpers.app_page_path(conn, page)
      App.current_tenant_url(conn, segment)
    end
  end

  defp fetch_classifieds(conn) do
    Classified
      |> Classified.of_current_tenant(conn)
      |> Classified.valid
      |> Classified.active
      |> Classified.sort_by_recent
      |> Repo.all
  end

end
