defmodule Alfred.MixProject do
  use Mix.Project

  def project do
    [
      app: :alfred,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Alfred.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
        {:nosedrum, "~> 0.3"},
        {:nostrum, git: "https://github.com/JM4ier/nostrum", override: true},
    ]
  end
end
