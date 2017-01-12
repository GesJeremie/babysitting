defmodule Babysitting.App.SitemapControllerTest do
  use Babysitting.ConnCase
  import Babysitting.ConnCase
  import Babysitting.Factory

  describe "home/2" do

    setup do
      tenant = insert(:tenant, [domain: "www.babysittingtest.fr"])
      classified = insert(:classified, %{tenant: tenant})

      conn =
        build_conn()
        |> with_host(tenant.domain)
        |> with_tenant

      [conn: conn]
    end

    test "render xml document", context do
      conn = get context.conn, app_sitemap_path(conn, :index)
      assert Enum.at(conn.resp_headers, 5) == {"content-type", "text/xml; charset=utf-8"}
    end

    test "render right domain for current tenant", context do
      conn = get context.conn, app_sitemap_path(conn, :index)
      assert conn.resp_body =~ "http://www.babysittingtest.fr/"
    end
  end

end
