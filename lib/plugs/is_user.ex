defmodule Babysitting.Plug.IsUser do
  
  import Plug.Conn
  alias Babysitting.Classified
  alias Babysitting.Helpers.App

  def init(default), do: default

  @doc """
  Will redirect to the auth page if it's not an user
  """
  def call(conn, _) do
    conn
      |> fetch_session
      |> get_session(:current_user)
      |> handle(conn)
  end

  defp handle(id, conn) when is_integer(id), do: conn
  
  defp handle(_, conn) do
    conn
      |> Phoenix.Controller.redirect(to: Babysitting.Router.Helpers.user_auth_path(conn, :index))
      |> halt
  end

end