defmodule Babysitting.Helpers.AppHelper do
  import Plug.Conn
  alias Babysitting.Repo
  alias Babysitting.Classified

  @doc """
  Return the current tenant
  """
  def current_tenant(conn) do
    conn.private
      |> Map.get(:current_tenant)
  end

  @doc """
  Return the current user.

  Note: We don't have the concept of "users", in fact
  a classified is an user.
  """
  def current_user(conn) do
    classified_id =
      conn
      |> fetch_session
      |> get_session(:current_user)

    Repo.get!(Classified, classified_id)
  end

  @doc """
  Return the tenants
  """
  def tenants(conn) do
    conn.private
      |> Map.get(:tenants)
  end

  @doc """
  Return the folder based on the slug of
  the current tenant. It's used to generate
  the path of the assets (logo, stylesheets, ...)
  """
  def current_tenant_folder(conn) do
    current_tenant(conn).slug |> String.trim_trailing("-dev")
  end

  @doc """
  Return the full url for the current tenant and
  suffix the path given
  """
  def current_tenant_url(conn, path) do
    "http://#{current_tenant(conn).domain}#{path}"
  end

  @doc """
  Return the site name for the current tenant
  """
  def current_tenant_site_name(conn) do
    "Baby Sitting #{current_tenant(conn).name}"
  end

  @doc """
  Return the facebook id for the current tenant
  Note: In the future we should store the data
  directly in the tenant table.
  """
  def current_tenant_facebook_page_id(conn) do
    case current_tenant(conn).slug do
      "paris" -> "1638919713096605"
      "marseille" -> "184713158658939"
      "london" -> "552729038239860"
      _ -> nil
    end
  end

  @doc """
  Return the logo of babysitting
  """
  def logo(conn) do
    "/images/logo.png"
  end

end
