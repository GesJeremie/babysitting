defmodule Babysitting.Router do
  use Babysitting.Web, :router
  use Babysitting.Plug.Website

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Babysitting.Plug.Website
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Babysitting do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Babysitting do
  #   pipe_through :api
  # end
end
