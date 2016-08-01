defmodule Babysitting.Helpers.Format do
  import Babysitting.Gettext

  @doc """
  Limit the number of words for the content given
  """
  def word_limit(content, limit \\ 50) do
    length = String.length(content)
    short = content
      |> String.split(" ")
      |> Enum.slice(0..limit)
      |> Enum.join(" ")

    if length < limit do
      short
    else
      short <> " ..."
    end
  end

  @doc """
  Format full name given a firstname and a lastname
  """
  def fullname(firstname, lastname) do
    String.capitalize(firstname) <> " " <> String.capitalize(lastname)
  end

  @doc """
  Humanize boolean value
  """
  def boolean(false), do: gettext("Yes")
  def boolean(_), do: gettext("No")

end