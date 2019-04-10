defmodule Metairie.MixProject do
  use Mix.Project

  def project do
    [
      app: :metairie,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),

      # Docs
      name: "Metairie",
      source_url: "https://github.com/revelrylabs/metairie",
      homepage_url: "https://github.com/revelrylabs/metairie",
      # The main page in the docs
      docs: [main: "Metairie", extras: ["README.md"]]
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
      {:telemetry, "~> 0.4.0"},
      {:vmstats, "~> 2.3"},
      {:statix, "~> 1.1"},
      {:ex_doc, "~> 0.20", only: :dev}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp description do
    """
    Plug for handling the creation of presigned urls for direct client-side uploading
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE", "CHANGELOG.md"],
      maintainers: ["Revelry Labs"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/revelrylabs/metairie"
      },
      build_tools: ["mix"]
    ]
  end
end
