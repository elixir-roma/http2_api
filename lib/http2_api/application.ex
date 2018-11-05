defmodule Http2Api.Application do
  @moduledoc false

  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    children = [
      supervisor(Http2Api.Post.Repo, []),
    ]

    opts = [strategy: :one_for_one, name: Http2Api.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
