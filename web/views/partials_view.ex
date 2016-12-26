defmodule Babysitting.PartialsView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{AppHelper}

  def hotjar_id(conn) do
    AppHelper.current_tenant(conn).hotjar
  end

  def google_analytics_id(conn) do
    AppHelper.current_tenant(conn).google_analytics
  end
end
