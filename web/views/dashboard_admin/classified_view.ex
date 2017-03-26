defmodule Babysitting.DashboardAdmin.ClassifiedView do
  import Babysitting.ClassifiedView, only: [fullname: 1, age: 1, phone: 1, url_classified: 2, url_avatar: 2]
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{DateHelper, FormatHelper}

  def format_boolean(bool) do
    FormatHelper.boolean(bool)
  end

  def valid(%{:valid => valid}), do: do_valid(valid)
  defp do_valid(true), do: gettext("Yes")
  defp do_valid(false), do: gettext("No")
  defp do_valid(_), do: gettext("Waiting validation")

  def status(%{:status => status}), do: do_status(status)
  defp do_status(true), do: gettext("Online")
  defp do_status(false), do: gettext("Offline")

end
