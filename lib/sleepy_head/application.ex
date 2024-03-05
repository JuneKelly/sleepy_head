defmodule SleepyHead.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SleepyHeadWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:sleepy_head, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SleepyHead.PubSub},
      # Start a worker by calling: SleepyHead.Worker.start_link(arg)
      # {SleepyHead.Worker, arg},
      # Start to serve requests, typically the last entry
      SleepyHeadWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SleepyHead.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SleepyHeadWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
