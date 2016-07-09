defmodule Babysitting.App.PageView do
  use Babysitting.Web, :view

  def town(town) do
    town |> String.capitalize
  end

  def word_limit(string, limit \\ 50) do
    string 
      |> String.split(" ")
      |> Enum.slice(0..1)
  end

end
