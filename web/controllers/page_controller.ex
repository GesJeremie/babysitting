defmodule Babysitting.PageController do
  use Babysitting.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
