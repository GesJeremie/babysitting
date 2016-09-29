defmodule Babysitting.LayoutView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.App

  def title(conn) do
    "Baby Sitting " <> App.current_tenant(conn).name
  end

  def current_tenant_stylesheet(conn) do
    "/stylesheets/#{App.current_tenant(conn).slug}.css"
  end
    
end
