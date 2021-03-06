defmodule Babysitting.Endpoint do
  use Phoenix.Endpoint, otp_app: :babysitting

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.

  # For development purposes, storage is served by nginx
  # in production with a persistent dokku storage
  plug Plug.Static,
    at: "/storage", from: Path.expand("storage")

  plug Plug.Static,
    at: "/", from: :babysitting, gzip: true,
    only: ~w(stylesheets fonts images javascripts favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_babysitting_key",
    signing_salt: "dsvpvUBL"

  plug Babysitting.Router
end
