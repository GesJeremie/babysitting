defmodule Babysitting.PageController do
  use Babysitting.Web, :controller

  def home(conn, _params) do
    render conn, "home.html", conn: conn
  end
end
