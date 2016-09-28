defmodule Babysitting.App.ClassifiedView do
  use Babysitting.Web, :view
  
  alias Babysitting.Helpers.{Date, Format}

  @valid_phone_length 10

  def fullname(%{:firstname => firstname, :lastname => lastname}) do
    Format.fullname(firstname, lastname)
  end
  
  def age(%{:birthday => birthday}) do
    "#{Date.age(birthday)} #{gettext("years old")}"
  end

  def phone(%{:phone => phone}) do
    formated = phone |> String.replace(".", "")

    case String.length(formated) do
      @valid_phone_length ->
        phone |> String.split("") |> Enum.chunk(2) |> Enum.join(".")
      _ ->
        phone
    end

  end

  def phone_hidden(%{:phone => phone}) do
    phone = 
      %{phone: phone}
      |> phone
      |> String.slice(0..-3)
    
    "#{phone}**"
  end

end
