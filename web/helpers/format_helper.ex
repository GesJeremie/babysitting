defmodule Babysitting.Helpers.FormatHelper do
  import Babysitting.Gettext

  @doc """
  Limit the number of words for the content given
  """
  def word_limit(content, limit \\ 50, separator \\ " ...") do
    words = String.split(content, " ")

    if length(words) <= limit do
      content
    else
      content =
        words
        |> Enum.slice(0..limit-1)
        |> Enum.join(" ")

      "#{content}#{separator}"
    end
  end

  @doc """
  Limit the number of chars for the content given
  """
  def char_limit(content, limit \\ 50, separator \\ " ...") do
    chars = String.split(content, "")

    if length(chars) <= limit do
      chars
    else
      content =
        chars
        |> Enum.slice(0..limit-1)
        |> Enum.join("")

      "#{content}#{separator}"
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
