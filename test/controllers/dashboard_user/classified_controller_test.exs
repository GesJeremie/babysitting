defmodule Babysitting.DashboardUser.ClassifiedControllerTest do
    import Babysitting.ConnCase
    import Babysitting.Factory

    use Babysitting.ConnCase
    use Bamboo.Test, shared: :true

    alias Babysitting.Email
    alias Babysitting.{Classified}

    describe "show/2" do

      test "render right classified", context do
        tenant = insert(:tenant)

        # Create some classifieds and the oene we want to test
        insert_list(5, :classified, %{tenant: tenant})
        classified = insert(:classified, %{tenant: tenant, email: "ges.jeremie@gmail.com"})

        # Create conn
        conn = build_conn() |> with_host(tenant.domain) |> with_session

        # Add session current user
        conn = conn |> fetch_session |> put_session(:current_user, classified.id)

        conn = get conn, user_classified_path(conn, :show)

        assert conn.assigns.classified.id == classified.id
      end

    end

end
