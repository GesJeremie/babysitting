defmodule Babysitting.DashboardUser.AccountController do
  use Babysitting.Web, :controller

  def index(conn, params) do
    text conn, "account"
  end
end