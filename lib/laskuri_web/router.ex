defmodule LaskuriWeb.Router do
  use LaskuriWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LaskuriWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LaskuriWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/metrics", MetricsLive.Index, :index
    live "/metrics/:month", MetricsLive.Index, :display

    live "/meter_values", MeterValueLive.Index, :index
    live "/meter_values/new", MeterValueLive.Index, :new
    live "/meter_values/:id/edit", MeterValueLive.Index, :edit

    live "/meter_values/:id", MeterValueLive.Show, :show
    live "/meter_values/:id/show/edit", MeterValueLive.Show, :edit

    live "/payments", PaymentLive.Index, :index
    live "/payments/new", PaymentLive.Index, :new
    live "/payments/:id/edit", PaymentLive.Index, :edit

    live "/payments/:id", PaymentLive.Show, :show
    live "/payments/:id/show/edit", PaymentLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LaskuriWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LaskuriWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  defp auth(conn, _opts) do
    username =
      if Mix.env() == :prod do
        System.fetch_env!("BA_USERNAME")
      else
        "dev"
      end

    password =
      if Mix.env() == :prod do
        System.fetch_env!("BA_PASSWORD")
      else
        "dev"
      end

    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end
end
