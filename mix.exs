defmodule Babysitting.Mixfile do
  use Mix.Project

  def project do
    [app: :babysitting,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Babysitting, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :httpoison, :keenex, :timex,
                    :faker_elixir_octopus, :phoenix_pubsub, :scrivener_html,
                    :bamboo, :bamboo_smtp, :ex_machina]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:phoenix_pubsub, "~> 1.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_ecto, "~> 3.0-rc"},
     {:phoenix_html, "~> 2.4"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.9"},
     {:comeonin, "~> 1.0"},
     {:uuid, "~> 1.1"},
     {:arc_ecto, "~> 0.3.1"},
     {:arc, "0.2.0"},
     {:cowboy, "~> 1.0"},
     {:poison, "~> 2.1", override: true},
     {:httpoison, "~> 0.9.0"},
     {:keenex, "~> 0.4"},
     {:html_entities, "~> 0.3"},
     {:timex, "~> 3.0.0"},
     {:bamboo, "~> 0.7"},
     {:bamboo_smtp, "~> 1.2.1"},
     {:scrivener_ecto, "~> 1.0"},
     {:scrivener_html, "~> 1.1"},
     {:ex_machina, "~> 1.0"},
     {:faker_elixir_octopus, "> 0.0.0", only: [:dev, :test]},
     {:credo, "~> 0.4", only: [:dev, :test]}]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds_dev.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "run priv/repo/seeds_test.exs", "test"]]
  end
end
