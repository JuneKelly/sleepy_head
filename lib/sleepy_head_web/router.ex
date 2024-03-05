defmodule SleepyHeadWeb.Router do
  use SleepyHeadWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SleepyHeadWeb do
    pipe_through :api
    get("/sleep", SleepyHeadController, :sleep)
  end
end
