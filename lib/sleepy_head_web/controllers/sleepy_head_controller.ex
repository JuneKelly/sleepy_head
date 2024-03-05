defmodule SleepyHeadWeb.SleepyHeadController do
  use SleepyHeadWeb, :controller

  require Logger

  @default_sleep_ms 1_000

  def sleep(conn, params) do
    sleep_ms =
      case params["ms"] do
        nil ->
          @default_sleep_ms

        n ->
          String.to_integer(n)
      end

    Logger.info("[SleepyHead] (#{inspect(self())}) sleeping for #{sleep_ms}")
    Process.sleep(sleep_ms)
    Logger.info("[SleepyHead] (#{inspect(self())}) done")

    conn
    |> put_status(:ok)
    |> text("OK")
  end
end
