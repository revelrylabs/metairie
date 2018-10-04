# Metairie

Modules for monitoring Elixir/Phoenix Apps.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `metairie` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:metairie, "~> 0.1.0"}
  ]
end
```

Uses the following packages for monitoring

- [statix](https://hex.pm/packages/statix): For sending data to a StatsD server, including datadog
- [vmstats](https://hex.pm/packages/vmstats): For getting erlang vm stats

## Usage

### Configuration

Before using the start/0 or start/1 function needs to be invoked. This should be called when the application starts. Underneath it's calling Metairie.StatsCollector.connect()

```elixir
def start(_type, _args) do
  # configuration
  configuration = [
      host: "127.0.0.1", # defaults to "127.0.0.1"
      port: "8125",  # defaults to "8125"
      prefix: "my_app", # defaults to nil
    ]

  :ok = Metairie.StatsCollector.start(default_configuration)
  # ...
end
```

### Phoenix Instrumentation

In your configuration for your endpoint, add `instrumenters: [Metairie.Phoenix.Instrumenter]`:

```elixir
config :my_app, MyAppWeb.Endpoint,
  # other configuration
  instrumenters: [Metairie.Phoenix.Instrumenter]
```

### Ecto Logging

In your configuration for repo, add the `Metairie.Ecto.Logger` logger:

```elixir
config :my_app, MyApp.Repo,
  # other configuration
  loggers: [{Ecto.LogEntry, :log, []}, {Metairie.Ecto.Logger, :record_ecto_metric, []}]
```

### Erlang VM Stats

Metaire uses `vmstats` to track Erlang VM stats. Add the following to your configuration

```elixir
config(
  :vmstats,
  sink: Metairie.Erlang.Stats,
  base_key: "my_app.erlang",
  key_separator: ".",
  interval: 1_000
)
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/metairie](https://hexdocs.pm/metairie).
