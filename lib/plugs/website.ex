defmodule Babysitting.Plug.Website do
  
  import Plug.Conn

  alias Babysitting.Repo
  alias Babysitting.Tenant

  def init(default), do: default

  def call(conn, _) do

    host = conn.host
    tenants = Repo.all(Tenant)

    # Find current tenant
    current_tenant =  Enum.reject(tenants, fn(tenant) -> host != tenant.domain end) |> Enum.at(0)

    conn |> put_private(:current_tenant, current_tenant)

  end

end