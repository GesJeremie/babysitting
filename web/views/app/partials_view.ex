defmodule Babysitting.App.PartialsView do
  use Babysitting.Web, :view
  import Babysitting.TenantView, only: [is_tenant_bordeaux: 1]
  alias Babysitting.Helpers.{AppHelper, AltHelper}

  def logo(conn) do
    AppHelper.logo(conn)
  end

  def alt_logo(conn) do
    AltHelper.logo(conn)
  end

  def facebook_link(conn) do
    AppHelper.current_tenant(conn).facebook
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
    |> AppHelper.tenants
    |> Enum.filter(&is_production(&1))
    |> Enum.filter(&is_not_current(conn, &1))
  end

  defp is_production(tenant) do
    (tenant.domain |> String.slice(-3, 3)) !== "dev"
  end

  defp is_not_current(conn, tenant) do
    AppHelper.current_tenant(conn).name !== tenant.name
  end

  def town(conn) do
    AppHelper.current_tenant(conn).name |> String.capitalize
  end

  @doc """
  Generate mailto: contact link depending the
  current tenant.
  """
  def contact_mailto(conn) do
    town = town(conn)
    contact_us = gettext("Contact us")
    subject = "[Baby Sitting #{town}] #{contact_us}"

    "mailto:group.babysitting@gmail.com?subject=#{subject}"
  end
end
