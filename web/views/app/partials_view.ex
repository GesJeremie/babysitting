defmodule Babysitting.App.PartialsView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.App

  def logo(conn) do
    App.logo(conn)
  end

  def facebook_link(conn) do
    App.current_tenant(conn).facebook
  end

  def tenants(conn) do
    App.tenants(conn)
  end

end
