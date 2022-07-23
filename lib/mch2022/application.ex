defmodule Mch2022.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Mch2022.Repo,
      # Start the Telemetry supervisor
      Mch2022Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mch2022.PubSub},
      # Start the Endpoint (http/https)
      Mch2022Web.Endpoint
      # Start a worker by calling: Mch2022.Worker.start_link(arg)
      # {Mch2022.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mch2022.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Mch2022Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
