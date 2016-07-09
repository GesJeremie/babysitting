defmodule Babysitting.App.PartialsView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.App

  def logo(conn) do
    "/images/tenants/#{App.current_tenant(conn).slug}/logo.png"
  end

  def facebook_link(conn) do
    App.current_tenant(conn).facebook
  end

end
