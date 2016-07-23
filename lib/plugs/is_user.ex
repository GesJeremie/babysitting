defmodule Babysitting.Plug.IsUser do
  
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    conn
      |> fetch_session
      |> get_session(:is_user)
      |> handle(conn)
  end

  defp handle(true, conn), do: conn
  
  defp handle(_, conn) do
    conn
      |> Phoenix.Controller.redirect(to: Phoenix.Router.user_auth_path(conn, :index))
      |> halt
  end

end