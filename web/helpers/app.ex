defmodule Babysitting.Helpers.App do
  import Plug.Conn
  alias Babysitting.Repo
  alias Babysitting.Ad

  def current_tenant(conn) do
    conn.private 
      |> Map.get(:current_tenant)
  end

  def tenants(conn) do
    conn.private 
      |> Map.get(:tenants)
  end

  def current_user_id(conn) do
    conn
      |> fetch_session
      |> get_session(:current_user)
  end

  def current_user(conn) do
    id = current_user_id(conn)
    Repo.get!(Ad, id)
  end
  
end