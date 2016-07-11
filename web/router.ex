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

  pipeline :admin_layout do
    plug :put_layout, {Babysitting.LayoutView, :dashboard_admin}
  end

  ##
  # App
  ##
  scope "/", Babysitting.App do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :home
    get "/ads/new", AdController, :new
    post "/ads", AdController, :create
    get "/ads/thankyou", AdController, :thankyou

  end

  ##
  # Dashboard Admin
  ##
  scope "/dashboard", Babysitting.DashboardAdmin, as: :admin do
    pipe_through [:browser, :admin_layout]

    # Base
    get "/", AnalyticsController, :index

    # Ads
    get "/ads", AdController, :index
    get "/ads/:id/validate", AdController, :validate
    get "/ads/:id/invalidate", AdController, :invalidate
    get "/ads/:id/show", AdController, :show

    # Auth
    get "/auth", AuthController, :index
    post "/auth/login", AuthController, :login
    get "/auth/logout", AuthController, :logout

  end

  ##
  # Dashboard User
  ##
  scope "/user", Babysitting.DashboardUser, as: :user do
    pipe_through [:browser]

    # Base
    get "/", AccountController, :index

    # Auth
    get "/auth", AuthController, :index
    post "/auth/login", AuthController, :login
    get "/auth/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", Babysitting do
  #   pipe_through :api
  # end
end
