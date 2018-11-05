defmodule Http2Api.Post.Get do
  require Logger
  import Plug.Conn

  alias Http2Api.Post.Post

  def init(options), do: options

  def call(conn, opts) do
    repo = opts[:repo]

    case Integer.parse(conn.path_params["id"]) do
      {intId, ""} ->
        case repo.get(Post, intId) do
          nil ->
            send_resp(conn, 404, "")

          post ->
            send_resp(conn, 200, serialize_post(post))
        end

      _ ->
        send_resp(put_resp_header(conn, "cache-control", "public,max-age=3600"), 404, "")
    end
  end

  defp serialize_post(%Post{} = post) do
    post
    |> Map.from_struct()
    |> Map.delete(:__meta__)
    |> Map.put("_links", %{
      "self" => %{
        "href" => "/post/#{post.id}"
      }
    })
    |> Jason.encode!()
  end
end
