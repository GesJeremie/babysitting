defmodule Babysitting.App.PageView do
  import Babysitting.ClassifiedView, only: [fullname: 1, age: 1, phone: 1, url_classified: 2, url_avatar: 2]
  use Babysitting.Web, :view
  use Phoenix.HTML

  import Scrivener.HTML

  alias Babysitting.Helpers.{DateHelper, FormatHelper, AppHelper, AltHelper, MicroDataHelper}

  def cover(conn) do
    "/images/tenants/#{AppHelper.current_tenant_folder(conn)}/cover.jpg"
  end

  def is_recent(%{:inserted_at => inserted_at}) do
    DateHelper.diff(inserted_at, :weeks) <= 2
  end

  def short_description(%{:description => description}) do
    description
      |> FormatHelper.word_limit
      |> text_to_html
  end

  def inserted_at(%{:inserted_at => inserted_at}) do
    Babysitting.Helpers.DateHelper.humanize(inserted_at)
  end

  def site_name(conn) do
    AppHelper.current_tenant_site_name(conn)
  end

  def town(conn) do
    AppHelper.current_tenant(conn).name
  end

  def url_home_page(conn) do
    AppHelper.current_tenant_url(conn, "/")
  end

  def url_thumbnail(conn) do
    "#{AppHelper.current_tenant_url(conn, "/images/tenants/")}#{AppHelper.current_tenant_folder(conn)}/thumbnail.jpg"
  end

  @doc """
  Return alt text for the avatar of a classified
  """
  def alt_thumb(conn, classified) do
    AltHelper.avatar_classified(conn, classified)
  end

  @doc """
  Return alt text for the avatar of a classified
  """
  def alt_mascot(conn) do
    AltHelper.mascot(conn)
  end

  @doc """
  Render micro data json ld for a classified
  """
  def micro_data(conn, :classified, classified) do
    MicroDataHelper.classified(conn, classified)
  end
end
