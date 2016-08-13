defmodule Babysitting.Helpers.App do
  import Plug.Conn
  alias Babysitting.Repo
  alias Babysitting.Ad

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


end
