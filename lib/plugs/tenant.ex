defmodule Babysitting.Plug.Tenant do

  @moduledoc """
  Given the domain name, it initialize the current tenant associated
  """

  import Plug.Conn

  alias Babysitting.Repo
  alias Babysitting.Tenant

  def init(default), do: default

  def call(conn, _) do

    tenants = Repo.all(Tenant)

    # Find current tenant
    current_tenant = tenants
      |> Enum.reject(fn(tenant) -> conn.host != tenant.domain end)

    case Enum.count(current_tenant) do
      0 ->
        conn
          |> put_status(404)
          |> halt

      _ ->
        current_tenant = current_tenant
          |> Enum.at(0)

        # Set the right locale for the current tenant
        Gettext.put_locale(Babysitting.Gettext, current_tenant.locale)

        # Pass it to the connection as private
        conn
          |> put_private(:current_tenant, current_tenant)
          |> put_private(:tenants, tenants)
    end
  end

end
