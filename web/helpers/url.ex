defmodule Babysitting.Helpers.Url do
  
  def host(conn) do
    conn.private |> Map.get(:website)
  end

end