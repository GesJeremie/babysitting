defmodule Babysitting.LayoutView do
  use Babysitting.Web, :view

  def title(conn) do
    "Baby Sitting " <> Babysitting.Helpers.Url.host(conn)
  end
end
