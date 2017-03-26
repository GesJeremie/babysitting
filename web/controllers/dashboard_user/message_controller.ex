defmodule Babysitting.DashboardUser.MessageController do

  # Uses
  use Babysitting.Web, :controller

  # Aliases
  alias Babysitting.ClassifiedContact
  alias Babysitting.Helpers.AppHelper

  # Plugs
  plug Babysitting.Plug.IsUser

  def index(conn, _params) do

    # Get messages of this baby sitter
    messages = ClassifiedContact
      |> ClassifiedContact.where(:classified_id, AppHelper.current_user(conn).id)
      |> ClassifiedContact.sort_by_recent
      |> Repo.all

    IO.inspect AppHelper.current_user(conn).id
    render conn, "index.html", %{messages: messages}
  end

end
