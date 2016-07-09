defmodule Babysitting.Router do
  use Babysitting.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Babysitting.Plug.Tenant
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Babysitting do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :home
    resources "/ads", AdController
  end

  scope "/dashboard", Babysitting do
    get "/", DashboardAdmin.AnalyticsController, :index
    get "/ads", DashboardAdmin.AdController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Babysitting do
  #   pipe_through :api
  # end
end
