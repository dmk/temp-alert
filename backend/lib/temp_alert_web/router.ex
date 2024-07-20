defmodule TempAlertWeb.Router do
  use TempAlertWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_root_layout, {TempAlertWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", TempAlertWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TempAlertWeb do
    pipe_through :api

    scope "/v1" do
      post "/alerts", AlertController, :create
      get "/alerts", AlertController, :index
      get "/alerts/:id", AlertController, :show
      delete "/alerts/:id", AlertController, :delete
    end
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:temp_alert, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TempAlertWeb.Telemetry
    end
  end
end
