defmodule Babysitting.Plug.RedirectNonWww do

  @moduledoc """
  Redirect non-www to www.
  Note: Dokku-redirect plugin is quite buggy for our app (multiple domains to same app) and I don't
  want to deal with nginx custom of dokku.
  """
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do

    cond do
      conn.host |> String.slice(0, 4) == "www." ->
        conn
      conn.host |> String.slice(0, 11) == "http://www." ->
        conn
      true ->
        redirect_to_www(conn)
    end

  end

  defp redirect_to_www(conn) do
    conn
    |> Phoenix.Controller.redirect(external: "http://www.#{conn.host}/")
    |> halt
  end

end
