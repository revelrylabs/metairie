defmodule Metairie.StatixImpl do
  @moduledoc false
  use Statix, runtime_config: true

  def base_tags do
    {hostname, 0} = System.cmd("hostname", [])
    hostname = String.replace(hostname, "\n", "")
    app = Application.get_env(:metairie, :otp_app)

    case app do
      nil ->
        [
          "hostname:#{hostname}"
        ]

      _ ->
        [
          "app:#{app}",
          "hostname:#{hostname}"
        ]
    end
  end
end
