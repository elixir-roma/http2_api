defmodule Http2Api.Post.PostPlug do
  require Logger
  import Plug.Conn

  alias Http2Api.Post.Post

  def init(options), do: options

  def call(conn, opts) do
    repo = opts[:repo]
    changeset = Post.changeset(%Post{}, conn.body_params)

    case repo.insert(changeset) do
      {:ok, post} ->
        Logger.info(fn -> inspect(post) end)
        send_resp(conn, 204, "")

      {:error, changeset} ->
        Logger.info(fn -> inspect(changeset) end)
        send_resp(conn, 422, "")
    end
  end
end
