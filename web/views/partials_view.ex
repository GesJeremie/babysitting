defmodule Babysitting.PartialsView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.App

  def hotjar_id(conn) do
    App.current_tenant(conn).hotjar
  end

  def google_analytics_id(conn) do
    App.current_tenant(conn).google_analytics
  end
end
