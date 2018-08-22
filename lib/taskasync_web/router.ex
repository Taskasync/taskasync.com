defmodule TaskasyncWeb.Router do
  use TaskasyncWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TaskasyncWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TaskasyncWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/how-it-works", PageController, :how_it_works
    get "/about", PageController, :about

    get "/join", UserController, :new
    post "/join", UserController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete

    resources "/tasks", TaskController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskasyncWeb do
  #   pipe_through :api
  # end
end
