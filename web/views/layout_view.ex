defmodule Babysitting.LayoutView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{AppHelper}

  def title(conn) do
    "Baby Sitting " <> AppHelper.current_tenant(conn).name
  end

  def current_tenant_stylesheet(conn) do
    "/stylesheets/#{AppHelper.current_tenant_folder(conn)}.css"
  end
end
