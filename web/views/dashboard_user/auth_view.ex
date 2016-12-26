defmodule Babysitting.DashboardUser.AuthView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{AppHelper}

  def logo(conn) do
    AppHelper.logo(conn)
  end
end
