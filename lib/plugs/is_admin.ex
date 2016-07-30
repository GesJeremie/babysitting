defmodule Babysitting.Plug.IsAdmin do
  
  import Plug.Conn

  def init(default), do: default

  @doc """
  Will redirect to the home page if it's not an admin
  """
  def call(conn, _) do
    conn
      |> fetch_session
      |> get_session(:is_admin)
      |> handle(conn)
  end

  defp handle(true, conn), do: conn
  
  defp handle(_, conn) do
    conn
      |> Phoenix.Controller.redirect(to: Babysitting.Router.Helpers.admin_auth_path(conn, :index))
      |> halt
  end

end