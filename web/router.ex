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

  pipeline :user_layout do
    plug :put_layout, {Babysitting.LayoutView, :dashboard_user}
  end

  ##
  # App
  ##
  scope "/", Babysitting.App, as: :app do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :home
    get "/about", PageController, :about
    get "/legal", PageController, :legal
    get "/contact", PageController, :contact
    get "/press", PageController, :press
    get "/faq", PageController, :faq

    get "/classifieds/new", ClassifiedController, :new
    get "/classifieds/:id/show", ClassifiedController, :show
    post "/classifieds", ClassifiedController, :create
    post "/classifieds/:id/contact", ClassifiedController, :create_contact
    get "/classifieds/thankyou", ClassifiedController, :thankyou

  end

  ##
  # Dashboard Admin
  ##
  scope "/dashboard", Babysitting.DashboardAdmin, as: :admin do
    pipe_through [:browser, :admin_layout]

    # Base
    get "/", AnalyticsController, :index

    # Ads
    get "/classifieds", ClassifiedController, :index
    get "/classifieds/:id/validate", ClassifiedController, :validate
    get "/classifieds/:id/invalidate", ClassifiedController, :invalidate
    get "/classifieds/:id/show", ClassifiedController, :show
    get "/classifieds/:id/edit", ClassifiedController, :edit
    put "/classifieds/:id/edit", ClassifiedController, :update

    # Auth
    get "/auth", AuthController, :index
    post "/auth/login", AuthController, :login
    get "/auth/logout", AuthController, :logout

  end

  ##
  # Dashboard User
  ##
  scope "/user", Babysitting.DashboardUser, as: :user do
    pipe_through [:browser, :user_layout]

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
