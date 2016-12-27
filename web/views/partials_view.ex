defmodule Babysitting.PartialsView do
  use Babysitting.Web, :view
  alias Babysitting.Helpers.{AppHelper, FormatHelper, DateHelper}
  import Plug.Conn

  def hotjar_id(conn) do
    AppHelper.current_tenant(conn).hotjar
  end

  def google_analytics_id(conn) do
    AppHelper.current_tenant(conn).google_analytics
  end

  def user_logged?(conn) do

    IO.inspect conn
    |> fetch_session
    |> get_session(:current_user)
    |> do_user_logged(conn)
  end

  defp do_user_logged(id, conn) when is_integer(id), do: true
  defp do_user_logged(_, conn), do: false

  def user(conn) do
    classified = AppHelper.current_user(conn)

    %{
      name: FormatHelper.fullname(classified.firstname, classified.lastname),
      email: classified.email,
      created_at: DateHelper.ecto_datetime_to_timestamp(classified.inserted_at)
    }
  end

end
