defmodule Metairie do
  @moduledoc """
  Modules for monitoring Elixir/Phoenix Apps.

  Adds monitoring for Phoenix, Ecto, and the Erlang VM

  ## Configuration

  ### Phoenix Instrumentation

  In your configuration for your endpoint, add `instrumenters: [Metairie.Phoenix.Instrumenter]`:

  ```elixir
  config :my_app, MyAppWeb.Endpoint,
    # other configuration
    instrumenters: [Metairie.Phoenix.Instrumenter]
  ```

  ### Erlang VM Stats

  Metaire uses `vmstats` to track Erlang VM stats. Add the following to your configuration

  ```elixir
  config(
    :vmstats,
    sink: Metairie.VMStats.Sink,
    base_key: "my_app.erlang",
    key_separator: ".",
    interval: 1_000
  )
  ```


  ### Statix (sending stats to StatsD/DataDog)

  ```elixir
  config :my_app, :statix,
    prefix: "my_app",
    host: "localhost",
    port: 8125
  ```

  ### Start
    Initializes the gathering of metrics in your application by calling `Metairie.init(:my_app)`


  ```elixir
  defmodule MyApp.Application do
  use Application

    def start(_type, _args) do
      import Supervisor.Spec

      Metairie.init(:my_app)
      ...
    end

  ```
  """

  @doc """
  Initializes the gathering of metrics in your application

  ## Examples

  In application

  ```elixir
  defmodule MyApp.Application do
  use Application

    def start(_type, _args) do
      import Supervisor.Spec

      Metairie.init(:my_app)
      ...
    end

  ```

  """
  def init(otp_app) do
    Application.put_env(:metairie, Metairie.StatsCollector, otp_app: otp_app)
    statix_config = Application.get_env(otp_app, :statix)
    Application.put_env(:statix, Metairie.StatsCollector, statix_config)
    :ok = Metairie.StatsCollector.connect()

    :telemetry.attach(
      "record_ecto_metric",
      [otp_app, :repo, :query],
      &Metairie.Ecto.Telemetry.record_ecto_metric/4,
      nil
    )
  end
end
