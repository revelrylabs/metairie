defmodule Metairie.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, [config]) do
    default = [
      host: "127.0.0.1",
      port: "8125",
      otp_app: nil,
      prefix: nil
    ]

    config = Keyword.merge(default, config)

    statix_config = [
      host: config[:host],
      port: config[:port],
      prefix: config[:port]
    ]

    Application.put_env(:statix, Metairie.StatixImpl, statix_config)
    Application.put_env(:vmstats, [])

    :ok = Metairie.StatixImpl.connect()

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Metairie.Worker.start_link(arg)
      # {Metairie.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Metairie.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
