defmodule Http2Api.Application do
  @moduledoc false

  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    children = [
      supervisor(Http2Api.Post.Repo, []),
      Plug.Cowboy.child_spec(
        scheme: :https,
        plug: Http2Api.MainRouter,
        options: [
          port: 4001,
          keyfile: "priv/server.key",
          certfile: "priv/server.pem",
          otp_app: :http2_api
        ]
      )
    ]

    opts = [strategy: :one_for_one, name: Http2Api.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
