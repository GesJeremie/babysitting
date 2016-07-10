defmodule Babysitting.Plug.IsAdmin do
  
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do

    # Fetch session is admin
    is_admin = conn |> fetch_session |> get_session(:is_admin)

    if is_admin do
      # Do nothing
      conn
    else
      # Redirect to the login page
      conn |> Phoenix.Controller.redirect(to: "/dashboard/auth") |> halt
    end

  end

end