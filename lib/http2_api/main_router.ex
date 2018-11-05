defmodule Http2Api.MainRouter do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  forward("/post", to: Http2Api.Post.Router)

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
