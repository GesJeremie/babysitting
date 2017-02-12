defmodule Babysitting.App.ClassifiedView do
  use Babysitting.Web, :view

  alias Babysitting.Helpers.{DateHelper, FormatHelper, AppHelper, AltHelper}

  @valid_phone_length 10

  @doc """
  Return fullname for the classified given
  """
  def fullname(%{:firstname => firstname, :lastname => lastname}) do
    FormatHelper.fullname(firstname, lastname)
  end

  @doc """
  Return age for the birthday given
  """
  def age(%{:birthday => birthday}) do
    "#{DateHelper.age(birthday)} #{gettext("years old")}"
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
    AppHelper.current_tenant_site_name(conn)
  end

  @doc """
  Generate full url for the classified given
  """
  def url_classified(conn, classified) do
    path = Babysitting.Router.Helpers.app_classified_path(conn, :show, classified.id)
    AppHelper.current_tenant_url(conn, path)
  end

  @doc """
  Generate full url for the avatar of the classified given
  """
  def url_avatar(conn, classified) do
    avatar = Babysitting.Avatar.url({classified.avatar, classified}, :thumb)

    unless is_nil(avatar) do
      path = "/" <> Babysitting.Avatar.url({classified.avatar, classified}, :thumb)
      AppHelper.current_tenant_url(conn, path)
    end
  end

  @doc """
  Generate url back listing
  """
  def url_back_listing(conn, classified) do
    if conn.query_params|> Map.has_key?("from_page") do
      "/?page=#{conn.query_params["from_page"]}#classified-#{classified.id}"
    else
      "/"
    end
  end

  @doc """
  Return a short description for og:description property.
  """
  def og_short_description(%{:description => description}) do
    description
      |> FormatHelper.char_limit(249)
  end

  @doc """
  Return a short description for meta description
  """
  def short_description(%{:description => description}) do
    description
      |> FormatHelper.char_limit(160)
  end

  @doc """
  Return alt text for the avatar of a classified
  """
  def alt_thumb(conn, classified) do
    AltHelper.avatar_classified(conn, classified)
  end

end
