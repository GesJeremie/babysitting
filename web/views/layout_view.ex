defmodule Babysitting.LayoutView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.App

  def title(conn) do
    "Baby Sitting " <> App.host(conn)
  end
  
end
