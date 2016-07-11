defmodule Babysitting.App.PageView do
  use Babysitting.Web, :view

  def town(town) do
    town |> String.capitalize
  end


end
