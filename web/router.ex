defmodule GT.Router do
  use GT.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug Guardian.Plug.EnsureAuthenticated, handler: GT.ErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GT do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login 
    resources "/users", UserController
  end

  scope "/admin", GT, as: :admin do
    pipe_through [:browser, :admin]
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GT do
  #   pipe_through :api
  # end
end
