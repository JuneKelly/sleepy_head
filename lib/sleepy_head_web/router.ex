defmodule SleepyHeadWeb.Router do
  use SleepyHeadWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :basic_auth
  end

  scope "/api", SleepyHeadWeb do
    pipe_through :api
    get("/sleep", SleepyHeadController, :sleep)
  end

  defp basic_auth(conn, _opts) do
    username = System.fetch_env!("AUTH_USERNAME")
    password = System.fetch_env!("AUTH_PASSWORD")
    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end
end
