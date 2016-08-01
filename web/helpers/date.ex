defmodule Babysitting.Helpers.Date do
  @moduledoc """
  Conveniences for shared view helpers. 
  """
  use Timex

  @doc """
  Return age given the birthday date
  """
  def age(birthday) do 
    [day, month, year] = birthday |> String.split("/")
    Date.today.year - String.to_integer(year)
  end


end
