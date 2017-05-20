defmodule Babysitting.ClassifiedView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{DateHelper, FormatHelper, AppHelper, AltHelper, MicroDataHelper}

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
  Given a classified, we extract a slug from it
  """
  def get_slug_classified(conn, classified) do
    baby_sitter = "Baby sitter"
    town = AppHelper.current_tenant(conn).name
    firstname = classified.firstname
    lastname = classified.lastname
    id = classified.id

    Slugger.slugify_downcase("#{baby_sitter} #{town} #{firstname} #{lastname} #{id}")
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

end
