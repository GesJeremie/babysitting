defmodule Babysitting.AppHelperTest do
  use Babysitting.ConnCase
  import Babysitting.ConnCase
  import Babysitting.Factory
  alias Babysitting.Helpers.App

  describe "current_tenant/1" do

    setup do 
      conn =
        build_conn()
        |> with_host("www.babysittingbordeaux.dev")
        |> with_tenant

      [conn: conn]
    end

    test "return a map", context do
      assert App.current_tenant(context.conn) |> is_map
    end

    test "return the properties", context do
      tenant = App.current_tenant(context.conn)

      for property <- [:domain, :id, :name, :slug, :facebook, :locale] do
        assert tenant |> Map.has_key?(property)
      end
    end

  end

  describe "current_user/1" do

    setup do
      classified = insert(:classified)

      conn =
        build_conn()
        |> with_session
        |> put_session(:current_user, classified.id)

      [conn: conn]
    end

    test "return a map", context do
      assert App.current_user(context.conn) |> is_map
    end

    test "return id", context do
      assert App.current_user(context.conn) |> Map.has_key?(:id)
    end

  end

  describe "tenants/1" do

    setup do
      conn = 
        build_conn()
        |> with_host("www.babysittingbordeaux.dev")
        |> with_tenant
      
      [conn: conn]
    end

    test "return map", context do
      assert App.tenants(context.conn) |> is_list
    end
  end

end
