defmodule Babysitting.DashboardAdmin.AnalyticsView do
  use Babysitting.Web, :view

  alias Babysitting.Helpers.{AppHelper}

  def data_tenants(conn) do
      conn
      |> fetch_tenants
      |> Enum.reduce(%{}, fn(tenant, acc) ->
          Map.put(acc, (tenant.id |> Integer.to_string), tenant.name)
        end)
      |> Poison.encode!
      |> Phoenix.HTML.raw
  end

  defp fetch_tenants(conn) do
    conn
    |> AppHelper.tenants
    |> Enum.filter(fn(tenant) ->
      if Mix.env === :dev do
        (tenant.domain |> String.slice(-3, 3)) === "dev"
      else
        (tenant.domain |> String.slice(-3, 3)) !== "dev"
      end
    end)
  end
end
