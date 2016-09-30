defmodule Babysitting.Helpers.App do
  import Plug.Conn
  alias Babysitting.Repo

  @doc """
  Return the current tenant
  """
  def current_tenant(conn) do
    conn.private
      |> Map.get(:current_tenant)
  end

  @doc """
  Return the tenants
  """
  def tenants(conn) do
    conn.private
      |> Map.get(:tenants)
  end

  @doc """
  Return the logo for the current tenant
  """
  def logo(conn) do
    "/images/tenants/#{current_tenant(conn).slug}/logo.png"  
  end

end
