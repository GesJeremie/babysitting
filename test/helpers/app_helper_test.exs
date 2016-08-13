defmodule Babysitting.AppHelperTest do

  use Babysitting.ConnCase
  import Babysitting.ConnCase
  alias Babysitting.Helpers.App

  test "current_tenant/1 return a map of the current tenant", %{conn: conn} do
    conn = conn
      |> with_tenant

    assert conn
      |> App.current_tenant
      |> is_map

  end

  test "tenants/1 return a list of the tenants", %{conn: conn} do
    conn = conn
      |> with_tenant

    assert conn
      |> App.tenants
      |> is_list
  end

end
