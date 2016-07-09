defmodule Babysitting.DashboardAdmin.AdView do
  use Babysitting.Web, :view

  def format_boolean(bool) do
    if bool do
      gettext("Yes")
    else
      gettext("No")
    end
  end
end
