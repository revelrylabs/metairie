defmodule Metairie.Erlang.Stats do
  @moduledoc false
  alias Metairie.StatsCollector

  @behaviour :vmstats_sink

  def collect(_type, name, value) do
    try do
      StatixImpl.gauge(IO.iodata_to_binary(name), value, tags: StatixImpl.base_tags())
    rescue
      ArgumentError ->
        nil
    catch
      :exit, _value ->
        nil
    end
  end
end
