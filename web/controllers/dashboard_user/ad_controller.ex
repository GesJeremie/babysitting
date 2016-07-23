defmodule Babysitting.DashboardUser.AccountController do
  use Babysitting.Web, :controller
  alias Babysitting.Ad
  alias Babysitting.Helpers.App

  plug Babysitting.Plug.IsUser


  def status_on(conn) do
  end

  def status_off(conn) do
  end

  defp switch_status(_) do
  end

end