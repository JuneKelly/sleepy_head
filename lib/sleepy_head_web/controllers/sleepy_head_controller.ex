defmodule SleepyHeadWeb.SleepyHeadController do
  use SleepyHeadWeb, :controller

  require Logger

  @default_sleep_ms 1_000

  def sleep(conn, params) do
    sleep_ms =
      case params["sleep"] do
        nil ->
          @default_sleep_ms

        n ->
          String.to_integer(n)
      end

    Logger.info("[SleepyHead] sleeping for #{sleep_ms}")
    Process.sleep(sleep_ms)

    conn
    |> put_status(:ok)
    |> text("OK")
  end
end
