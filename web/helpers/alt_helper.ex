defmodule Babysitting.Helpers.AltHelper do
  import Plug.Conn
  import Babysitting.Gettext
  alias Babysitting.Helpers.{AppHelper, FormatHelper}

  @doc """
  Return alt text for the avatar of a classified
  """
  def avatar_classified(conn, classified) do
    data = [
      town: AppHelper.current_tenant(conn).name,
      fullname: FormatHelper.fullname(classified.firstname, classified.lastname)
    ]

    Babysitting.Gettext.gettext("Profile picture of baby sitter %{fullname} living in %{town}", data)
  end

  @doc """
  Return alt text for the logo
  """
  def logo(conn) do
    town = AppHelper.current_tenant(conn).name

    Babysitting.Gettext.gettext("Logo Baby Sitting %{town}", [town: town])
  end

  @doc """
  Return alt text for the mascot image
  """
  def mascot(conn) do
    town = AppHelper.current_tenant(conn).name

    Babysitting.Gettext.gettext("Mascot Baby Sitting %{town}", [town: town])
  end


end
