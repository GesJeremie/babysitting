defmodule Babysitting.DashboardAdmin.ClassifiedView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{Date, Format}

  def format_boolean(bool) do
    Format.boolean(bool)
  end

  def fullname(%{:firstname => firstname, :lastname => lastname}) do
    Format.fullname(firstname, lastname)
  end

  def valid(%{:valid => valid}), do: do_valid(valid)
  defp do_valid(true), do: gettext("Yes")
  defp do_valid(false), do: gettext("No")
  defp do_valid(_), do: gettext("Waiting validation")

  def status(%{:status => status}), do: do_status(status)
  defp do_status(true), do: gettext("Online")
  defp do_status(false), do: gettext("Offline")

  def age(%{:birthday => birthday}) do
    Date.age(birthday)
  end



end
