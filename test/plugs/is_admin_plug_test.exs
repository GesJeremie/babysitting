defmodule Babysitting.IsAdminPlugTest do

  use Babysitting.ConnCase
  import Babysitting.ConnCase

  test "admin is redirected when not authenticated" do
    conn = conn()
      |> with_session
      |> Babysitting.Plug.IsAdmin.call(%{})

    assert redirected_to(conn) == admin_auth_path(conn, :index)
  end

  test "admin is not redirect when authenticated" do
    conn = conn()
      |> with_session
      |> put_session(:is_admin, true)
      |> Babysitting.Plug.IsAdmin.call(%{})

      assert not_redirected?(conn)
  end

  defp not_redirected?(conn) do
    conn.status != 302
  end

end
