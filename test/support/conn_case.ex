defmodule Babysitting.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Babysitting.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]

      import Babysitting.Router.Helpers

      # The default endpoint for testing
      @endpoint Babysitting.Endpoint
    end
  end

  setup tags do
   :ok = Ecto.Adapters.SQL.Sandbox.checkout(Babysitting.Repo)

   unless tags[:async] do
     Ecto.Adapters.SQL.Sandbox.mode(Babysitting.Repo, {:shared, self()})
   end

   conn = 
    Phoenix.ConnTest.build_conn()
    |> with_host

   {:ok, conn: conn}
  end

  def with_session(conn) do
    session_opts = Plug.Session.init(store: :cookie, key: "_app",
                                     encryption_salt: "abc", signing_salt: "abc")
    conn
      |> Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
      |> Plug.Session.call(session_opts)
      |> Plug.Conn.fetch_session()
  end

  def with_host(conn) do
    with_host(conn, "www.babysittingbordeaux.dev")
  end

  def with_host(conn, host) do
    # Let's add the host
    conn = %{conn | host: host}
  end

  def with_tenant(conn) do
    conn
      |> with_session
      |> Babysitting.Plug.Tenant.call(%{})
  end

  def redirected?(conn) do
    conn.status == 302
  end

  def not_redirected?(conn) do
    conn.status != 302
  end

end
