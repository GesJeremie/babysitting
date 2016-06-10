defmodule Babysitting.PageController do
  use Babysitting.Web, :controller

  def index(conn, _params) do
    IO.inspect (Enum.into(conn.req_headers, %{}) |> Map.get("host"))
    #IO.inspect Atom.to_string(conn.scheme) <> "://" <> (Enum.into(conn.req_headers, %{}) |> Map.get("host")) <> conn.request_path
    render conn, "index.html"
  end
end
