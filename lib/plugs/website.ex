defmodule Babysitting.Plug.Website do
  
  import Plug.Conn

  def init(default), do: default

  def call(conn, _) do

    # Fetch domain name and strip www.
    host = conn.host |> String.replace("www.", "")

    # Match the right website
    website =
      case host do 
        "babysittingbordeaux.dev" -> "bordeaux"
        "babysittingparis.dev" -> "paris"
        _others -> false
      end

    # Set a private variable in the connexion
    conn |> put_private(:website, website)

  end

end