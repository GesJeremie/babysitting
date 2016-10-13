defmodule Babysitting.PageControllerTest do
  use Babysitting.ConnCase
  import Babysitting.ConnCase
  import Babysitting.Factory
  alias Babysitting.Classified

  describe "home/2" do
    test "render right classifieds" do
      tenant = insert(:tenant)
      insert_list(10, :classified)
      insert_list(5, :classified, %{tenant: tenant, valid: true, status: true})
      insert_list(1, :classified, %{tenant: tenant, valid: false})

      conn = build_conn() |> with_host(tenant.domain)
      conn = get conn, app_page_path(conn, :home)

      assert conn.assigns.classifieds.entries |> length == 5
    end
  end

end
