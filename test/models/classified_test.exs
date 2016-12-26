defmodule Babysitting.ClassifiedTest do
  use Babysitting.ConnCase
  import Babysitting.ConnCase
  import Babysitting.Factory
  alias Babysitting.Classified

  describe "of_current_tenant/2" do

    setup do
      # Create tenant
      tenant = insert(:tenant)

      # Create 2 classifieds for this tenant
      insert_list(2, :classified, %{tenant: tenant})

      # Create other classifieds attached to other tenants
      insert_list(30, :classified)

      # Build the connection for our first tenant
      conn =
        build_conn()
        |> with_host(tenant.domain)
        |> with_tenant

      [conn: conn]
    end

    test "return the right classifieds", context do
      classifieds =
        Classified
        |> Classified.of_current_tenant(context.conn)
        |> Repo.all

      assert classifieds |> length == 2
    end

  end

  describe "simple queries" do

    setup do
      insert_list(4, :classified, %{valid: true})
      insert_list(3, :classified, %{valid: false})
      insert_list(5, :classified, %{valid: nil})

      :ok
    end

    test "invalid/1" do
      classifieds = Classified |> Classified.invalid |> Repo.all
      assert length(classifieds) == 3
    end

    test "valid/1" do
      classifieds = Classified |> Classified.valid |> Repo.all
      assert length(classifieds) == 4
    end

    test "waiting/1" do
      classifieds = Classified |> Classified.waiting |> Repo.all
      assert length(classifieds) == 5
    end

    test "exists/1" do
      exists = Classified |> Repo.all |> Classified.exists?
      assert exists |> is_boolean
    end

    test "where/3" do
      classifieds = Classified |> Classified.where(:valid, true) |> Repo.all
      assert classifieds |> length == 4
    end

  end

end

