use Mix.Config

config :ecto_mnesia,
  host: {:system, :atom, "MNESIA_HOST", Kernel.node()},
  storage_type: {:system, :atom, "MNESIA_STORAGE_TYPE", :disc_copies}

config :mnesia,
  dir: 'priv/data/mnesia'

config :http2_api, Http2Api.Post.Repo, adapter: EctoMnesia.Adapter

config :http2_api, :ecto_repos, [Http2Api.Post.Repo]
