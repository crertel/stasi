defmodule StasiWeb.Router do
  use StasiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StasiWeb do
    pipe_through :browser
    get "/", PageController, :index
    resources "/agent_requests", AgentRequestController
  end

  scope "/", StasiWeb do
    pipe_through :api
    post "/report", PageController, :receive_update
  end

  # Other scopes may use custom stacks.
  # scope "/api", StasiWeb do
  #   pipe_through :api
  # end
end
