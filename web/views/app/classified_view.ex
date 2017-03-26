defmodule Babysitting.App.ClassifiedView do

  import Babysitting.ClassifiedView, only: [fullname: 1, age: 1, phone: 1, url_classified: 2, url_avatar: 2]
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{DateHelper, FormatHelper, AppHelper, AltHelper, MicroDataHelper}

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

  @doc """
  Render micro data json ld for a classified
  """
  def micro_data(conn, :classified, classified) do
    MicroDataHelper.classified(conn, classified)
  end

end
