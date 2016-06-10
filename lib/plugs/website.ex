defmodule Babysitting.Plug.Website do
  
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do
    IO.inspect conn.host
    conn |> put_private(:website, "bordeaux")
  end

end