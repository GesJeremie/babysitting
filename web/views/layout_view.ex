defmodule Babysitting.LayoutView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{AppHelper}

  def title(conn) do
    town = AppHelper.current_tenant(conn).name
    Babysitting.Gettext.gettext("Need a Baby Sitter in %{town} ?", [town: town])
  end

  def description(conn) do
    Babysitting.Gettext.gettext("Free, no subscription, simple and effective!")
  end

  def current_tenant_stylesheet(conn) do
    "/stylesheets/#{AppHelper.current_tenant_folder(conn)}.css"
  end

  def html_current_lang(conn) do
    AppHelper.current_tenant(conn).locale |> String.slice(0, 2)
  end

end
