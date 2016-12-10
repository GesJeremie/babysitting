defmodule Babysitting.Helpers.App do
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
  Return the current user (classified)
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
  Return the logo of babysitting
  """
  def logo(conn) do
    "/images/logo.png"
  end

end
