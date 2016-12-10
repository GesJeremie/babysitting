defmodule Babysitting.App.PageView do
  use Babysitting.Web, :view
  use Phoenix.HTML

  import Scrivener.HTML
  
  alias Babysitting.Helpers.{Date, Format, App}

  def town(town) do
    town |> String.capitalize
  end

  def cover(conn) do
    "/images/tenants/#{App.current_tenant_folder(conn)}/cover.jpg"
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
