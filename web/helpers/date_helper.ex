defmodule Babysitting.Helpers.DateHelper do
  @moduledoc """
  Conveniences for shared date helpers.
  """
  import Babysitting.Gettext
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
  def ecto_datetime_to_timestamp(ecto_datetime) do
    ecto_datetime
    |> Ecto.DateTime.to_erl
    |> :calendar.datetime_to_gregorian_seconds
    |> Kernel.-(62167219200)
  end

  @doc """
  Convert an ecto datetime to a timex one
  """
  def ecto_to_timex_datetime(ecto_datetime) do
    string_datetime = Ecto.DateTime.to_string(ecto_datetime)
    {:ok, timex_datetime} = Timex.parse(string_datetime, "{YYYY}-{0M}-{D} {h24}:{m}:{s}")
    timex_datetime
  end

  @doc """
  Humanize date from ecto datetime
  Note: This code is a shame, sorry.
  """
  def humanize(ecto_datetime) do
    now = Timex.now
    timex_datetime = ecto_to_timex_datetime(ecto_datetime)

    seconds = Timex.diff(now, timex_datetime, :seconds)
    minutes = Timex.diff(now, timex_datetime, :minutes)
    hours = Timex.diff(now, timex_datetime, :hours)
    days = Timex.diff(now, timex_datetime, :days)
    weeks = Timex.diff(now, timex_datetime, :weeks)
    months = Timex.diff(now, timex_datetime, :months)
    years = Timex.diff(now, timex_datetime, :years)

    cond do
      seconds < 60 -> ngettext("%{seconds} second ago", "%{seconds} seconds ago", seconds, seconds: seconds)
      minutes < 60 -> ngettext("%{minutes} minute ago", "%{minutes} minutes ago", minutes, minutes: minutes)
      hours < 24 -> ngettext("%{hours} hour ago", "%{hours} hours ago", hours, hours: hours)
      days < 7 -> ngettext("Yesterday", "%{days} days ago", days, days: days)
      weeks < 4 -> ngettext("%{weeks} week ago", "%{weeks} weeks ago", weeks, weeks: weeks)
      months < 12 -> ngettext("%{months} month ago", "%{months} months ago", months, months: months)
      true -> ngettext("%{years} year ago", "%{years} years ago", years, years: years)
    end
  end

  @doc """
  Check the difference between two dates. It's a simple
  alias of Timex.diff which support the ecto datetime
  """
  def diff(ecto_datetime, unit) do
    now = Timex.now
    timex_datetime = ecto_to_timex_datetime(ecto_datetime)

    Timex.diff(now, timex_datetime, unit)
  end

end
