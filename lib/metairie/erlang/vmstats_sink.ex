defmodule Metairie.VMStats.Sink do
  @moduledoc false
  alias Metairie.StatsCollector
  require Logger

  @behaviour :vmstats_sink
  def collect(_type, name, value) do
    try do
      StatsCollector.gauge(IO.iodata_to_binary(name), value, tags: StatsCollector.base_tags())
    rescue
      ArgumentError ->
        nil
    catch
      :exit, _value ->
        nil
    end
  end
end
