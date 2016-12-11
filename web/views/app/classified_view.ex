defmodule Babysitting.App.ClassifiedView do
  use Babysitting.Web, :view
  
  alias Babysitting.Helpers.{Date, Format, App}

  @valid_phone_length 10

  @doc """
  Return fullname for the classified given
  """
  def fullname(%{:firstname => firstname, :lastname => lastname}) do
    Format.fullname(firstname, lastname)
  end
  
  @doc """
  Return age for the birthday given
  """
  def age(%{:birthday => birthday}) do
    "#{Date.age(birthday)} #{gettext("years old")}"
  end

  @doc """
  Try to format the phone if possible
  """
  def phone(%{:phone => phone}) do
    formated = phone |> String.replace(".", "")

    case String.length(formated) do
      @valid_phone_length ->
        phone |> String.split("") |> Enum.chunk(2) |> Enum.join(".")
      _ ->
        phone
    end

  end

  @doc """
  Return the phone obfuscated
  """
  def phone_hidden(%{:phone => phone}) do
    phone = 
      %{phone: phone}
      |> phone
      |> String.slice(0..-3)
    
    "#{phone}**"
  end

  @doc """
  Return the site name of the current tenant
  """
  def site_name(conn) do
    App.current_tenant_site_name(conn)
  end

  @doc """
  Generate full url for the classified given
  """
  def url_classified(conn, classified) do
    path = Babysitting.Router.Helpers.app_classified_path(conn, :show, classified.id)
    App.current_tenant_url(conn, path)
  end

  def url_avatar(conn, classified) do
    path = Babysitting.Avatar.url({classified.avatar, classified}, :thumb)
    App.current_tenant_url(conn, path)
  end

end
