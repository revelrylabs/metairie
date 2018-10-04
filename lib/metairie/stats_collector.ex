defmodule Metairie.StatsCollector do
  @moduledoc false
  use Statix, runtime_config: true

  @default_configuration [
    host: "127.0.0.1",
    port: "8125",
    prefix: nil
  ]

  def base_tags do
    {hostname, 0} = System.cmd("hostname", [])
    hostname = String.replace(hostname, "\n", "")

    [
      "hostname:#{hostname}"
    ]
  end

  def start do
    start(@default_configuration)
  end

  def start(config) do
    config = Keyword.merge(@default_configuration, config)

    statix_config = [
      host: config[:host],
      port: config[:port],
      prefix: config[:port]
    ]

    Application.put_env(:statix, Metairie.StatsCollector, statix_config)

    Metairie.StatsCollector.connect()
  end
end
