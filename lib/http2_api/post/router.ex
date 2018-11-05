defmodule Http2Api.Post.Router do
  use Plug.Router

  alias Http2Api.Post.Cget
  alias Http2Api.Post.PostPlug
  alias Http2Api.Post.Get
  alias Http2Api.Post.Repo

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get("/", to: Cget, init_opts: [repo: Repo])
  post("/", to: PostPlug, init_opts: [repo: Repo])
  get("/:id", to: Get, init_opts: [repo: Repo])

  match _ do
    send_resp(conn, 404, "")
  end
end
