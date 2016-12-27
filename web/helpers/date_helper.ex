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

  @doc """
  Convert ecto datetime to unix timestamp
  Note: https://elixirforum.com/t/how-to-convert-ecto-datetime-to-unix-timestamps/1165
  """
  def ecto_datetime_to_timestamp(datetime) do
    datetime
    |> Ecto.DateTime.to_erl
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.-(62167219200)
  end

end
