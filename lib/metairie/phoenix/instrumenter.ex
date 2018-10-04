defmodule Metairie.Phoenix.Instrumenter do
  @moduledoc false

  alias Metairie.StatsCollector

  @doc false
  def phoenix_controller_call(:start, _compile_metadata, runtime_metadata) do
    StatixImpl.increment("phoenix.request.count", 1, tags: tags(runtime_metadata.conn))

    runtime_metadata
  end

  @doc false
  def phoenix_controller_call(:stop, diff, result_of_before_callback) do
    StatixImpl.increment("phoenix.response.count", 1, tags: tags(result_of_before_callback.conn))

    StatixImpl.histogram("phoenix.response.time", diff, tags: tags(result_of_before_callback.conn))
  end

  defp tags(conn) do
    StatixImpl.base_tags() ++
      [
        "method:#{conn.method}",
        "path:#{conn.request_path}",
        "query:#{conn.query_string}",
        "action:#{conn.private.phoenix_action}",
        "controller:#{conn.private.phoenix_controller}"
      ]
  end
end
