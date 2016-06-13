defmodule Babysitting.Helpers.App do
  
  def current_tenant(conn) do
    conn.private |> Map.get(:tenant)
  end

  def current_tenant_domain(conn) do
    current_tenant(conn)[:domain]
  end

  def current_tenant_slug(conn) do
    current_tenant(conn)[:slug]
  end

  def current_tenant_name(conn) do
    current_tenant(conn)[:name]
  end

end