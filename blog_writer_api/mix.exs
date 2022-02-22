defmodule BlogWriterApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {App.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.3"},
      {:murmur, "~> 1.0"},
      {:redix, "~> 1.1"},
      {:amqp, "~> 3.0"},
      {:uuid, "~> 1.1.8"},
      {:ecto_sql, "~> 3.7"},
      {:postgrex, "~> 0.16.1"}
    ]
  end
end
