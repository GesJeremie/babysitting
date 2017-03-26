defmodule Babysitting.DashboardAdmin.MessageController do

  # Uses
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.ClassifiedContact

  # Plugs
  plug Babysitting.Plug.IsAdmin

  def index(conn, _params) do

    messages = ClassifiedContact
      |> ClassifiedContact.sort_by_recent
      |> Repo.all
      |> Repo.preload(classified: :tenant)

    render conn, "index.html", %{messages: messages}
  end

end
