defmodule Babysitting.App.PartialsView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.App

  def logo(conn) do
    App.logo(conn)
  end

  def facebook_link(conn) do
    App.current_tenant(conn).facebook
  end

  ##
  # Tenants is used to display the link for the other 
  # websites. We want to fetch only the websites in 
  # production.
  # 
  # Note: It could be improved with a migration and setup
  # a field "environment" in the table tenant. Let's say
  # it's okay for the time being.
  ###
  def tenants(conn) do
    conn
    |> App.tenants
    |> Enum.filter(fn(tenant) ->
      (tenant.domain |> String.slice(-3, 3)) !== "dev"
    end)
  end

end
