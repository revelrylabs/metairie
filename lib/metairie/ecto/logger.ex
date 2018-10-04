defmodule Metairie.Ecto.Logger do
  @moduledoc false
  alias Metairie.StatixImpl

  def record_ecto_metric(entry) do
    try do
      tags =
        StatixImpl.base_tags() ++
          [
            "query:#{entry.query}",
            "table:#{entry.source}"
          ]

      queue_time = entry.queue_time || 0
      duration = entry.query_time + queue_time

      StatixImpl.increment(
        "ecto.query.count",
        1,
        tags: tags
      )

      StatixImpl.histogram("ecto.query.exec.time", duration, tags: tags)
      StatixImpl.histogram("ecto.query.queue.time", queue_time, tags: tags)
    rescue
      ArgumentError ->
        nil
    catch
      :exit, _value ->
        nil
    end
  end
end
