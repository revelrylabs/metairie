defmodule Metairie.Ecto.Telemetry do
  @moduledoc false
  alias Metairie.StatsCollector

  def record_ecto_metric([_, :repo, :query], latency, entry, _config) do
    try do
      tags =
        StatsCollector.base_tags() ++
          [
            "query:#{entry.query}",
            "table:#{entry.source}"
          ]

      queue_time = latency.queue_time || 0
      duration = latency.query_time + queue_time

      StatsCollector.increment(
        "ecto.query.count",
        1,
        tags: tags
      )

      StatsCollector.histogram("ecto.query.exec.time", duration, tags: tags)
      StatsCollector.histogram("ecto.query.queue.time", queue_time, tags: tags)
    rescue
      ArgumentError ->
        nil
    catch
      :exit, _value ->
        nil
    end
  end
end
