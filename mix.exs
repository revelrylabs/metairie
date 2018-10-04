defmodule Metairie.MixProject do
  use Mix.Project

  def project do
    [
      app: :metairie,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.3.0-rc"},
      {:ecto, "~> 2.2"},
      {:vmstats, "~> 2.3"},
      {:statix, "~> 1.1"}
    ]
  end
end
