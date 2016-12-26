defmodule Babysitting.Helpers.DateHelper do
  @moduledoc """
  Conveniences for shared date helpers.
  """
  use Timex

  @doc """
  Return age given the birthday date
  """
  def age(birthday) do
    {_, birthday} =
      birthday
      |> Timex.parse("{0D}/{0M}/{YYYY}")

    now = Timex.now

    Timex.diff(now, birthday, :years)
  end


end
