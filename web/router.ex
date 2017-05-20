defmodule Babysitting.Router do
  use Babysitting.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Babysitting.Plug.RedirectNonWww
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
    get "/sitemap.xml", SitemapController, :index

    post "/classifieds", ClassifiedController, :create
    get "/classifieds/new", ClassifiedController, :new
    get "/classifieds/thankyou", ClassifiedController, :thankyou
    get "/classifieds/:slug", ClassifiedController, :show
    post "/classifieds/:id/contact", ClassifiedController, :create_contact
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
    get "/classifieds/:id/delete", ClassifiedController, :delete

    # Messages
    get "/messages", MessageController, :index

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
    get "/", ClassifiedController, :index

    # Classified
    get "/classified/show", ClassifiedController, :show
    put "/classified/edit", ClassifiedController, :update

    # Security
    get "/security", SecurityController, :index
    get "/security/password", SecurityController, :password
    put "/security/password", SecurityController, :update_password

    # Message
    get "/messages", MessageController, :index

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
