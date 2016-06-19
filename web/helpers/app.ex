defmodule Babysitting.Helpers.App do
  
  def current_tenant(conn) do
    conn.private |> Map.get(:current_tenant)
  end
  
end