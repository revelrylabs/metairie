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
- [telemetry](https://hex.pm/packages/telemetry): For gathering ecto stats

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/metairie](https://hexdocs.pm/metairie).
