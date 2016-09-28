defmodule Babysitting.App.ClassifiedView do
  use Babysitting.Web, :view
  
  alias Babysitting.Helpers.{Date, Format}

  def fullname(%{:firstname => firstname, :lastname => lastname}) do
    Format.fullname(firstname, lastname)
  end
  
  def age(%{:birthday => birthday}) do
    "#{Date.age(birthday)} #{gettext("years old")}"
  end

end
