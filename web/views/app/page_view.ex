defmodule Babysitting.App.PageView do
  use Babysitting.Web, :view
  use Phoenix.HTML

  import Scrivener.HTML
  
  alias Babysitting.Helpers.{Date, Format}

  def town(town) do
    town |> String.capitalize
  end

  def age(%{:birthday => birthday}) do
    "#{Date.age(birthday)} #{gettext("years old")}"
  end

  def short_description(%{:description => description}) do
    description
      |> Format.word_limit
      |> text_to_html
  end

  def fullname(%{:firstname => firstname, :lastname => lastname}) do
    Format.fullname(firstname, lastname)
  end


end
