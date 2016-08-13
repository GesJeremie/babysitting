defmodule Babysitting.Plug.IsUserPlugTest do

  use Babysitting.ConnCase
  import Babysitting.ConnCase

  test "user is redirect when not authenticated" do
      conn = conn()
        |> with_session
        |> Babysitting.Plug.IsUser.call(%{})

      assert redirected_to(conn) == user_auth_path(conn, :index)
  end

  test "user is not redirected when authenticated" do
    conn = conn()
      |> with_session
      |> put_session(:is_user, true)
      |> Babysitting.Plug.IsUser.call(%{})

      assert not_redirected?(conn)
  end

end
