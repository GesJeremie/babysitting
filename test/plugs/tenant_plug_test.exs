defmodule Babysitting.TenantPlugTest do
  use Babysitting.ConnCase

  test "set the current tenant for a valid host" do
    conn = 
      conn_valid_host
      |> Babysitting.Plug.Tenant.call(%{})

    assert conn.status != 404
    assert (conn.private |> Map.has_key?(:current_tenant)) == true
    assert (conn.private |> Map.has_key?(:tenants)) == true
  end

  test "renders 404 status for invalid host" do
    conn = 
      conn_invalid_host
      |> Babysitting.Plug.Tenant.call(%{})

    assert conn.status == 404
  end

  defp conn_valid_host() do
    build_conn_host("www.babysittingbordeaux.dev")
  end

  defp conn_invalid_host() do
    build_conn_host("www.zombieforever.com")
  end

  defp build_conn_host(domain) do
    conn = build_conn()
    conn = %{conn | host: domain}
  end


end
