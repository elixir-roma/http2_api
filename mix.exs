defmodule Http2Api.MixProject do
  use Mix.Project

  def project do
    [
      app: :http2_api,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Http2Api.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:ecto_mnesia, "~> 0.9.0"},
      {:jason, "~> 1.1"}
    ]
  end
end
