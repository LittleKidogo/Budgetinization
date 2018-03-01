defmodule Spender.Mixfile do
  use Mix.Project

  def project do
    [
      app: :spender,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
          "coveralls": :test,
          "coveralls.detail": :test,
          "coveralls.post": :test,
          "coveralls.html": :test
        ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Spender.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:excoveralls, "~> 0.7", only: :test}, #test reporting on the ci
      {:ex_machina,"~>2.0", only: :test},
      {:hackney, "~> 1.8.0", override: true}, #coveralls uses this version of hackney
      {:ja_serializer, "~> 0.12"},
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:guardian, "~> 1.0"}, # Authentication (JWT)
      {:cowboy, "~> 1.0"},
      {:ueberauth, "~> 0.4"},
      {:ueberauth_google, "~> 0.5"},
      {:ueberauth_facebook, "~> 0.7"},
      {:oauth, github: "tim/erlang-oauth"}, #for twitter
      {:ueberauth_twitter, "~> 0.2"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
