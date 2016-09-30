defmodule Babysitting.DashboardUser.AuthView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.App

  def logo(conn) do
    App.logo(conn)
  end
end
