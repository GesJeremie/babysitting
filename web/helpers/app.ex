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

  @doc """
  Return the current tenant id
  """
  def current_user_id(conn) do
    conn
      |> fetch_session
      |> get_session(:current_user)
  end

  @doc """
  Return the current user
  """
  def current_user(conn) do
    id = current_user_id(conn)
    Repo.get!(Ad, id)
  end
  
end