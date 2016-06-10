defmodule Babysitting.Helpers.App do
  
  def host(conn) do
    conn.private |> Map.get(:website)
  end

end