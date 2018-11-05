defmodule Http2Api.Post.Cget do
  require Logger
  import Plug.Conn

  alias Http2Api.Post.Post

  def init(options), do: options

  def call(conn, opts) do
    repo = opts[:repo]

    case repo.all(Post) do
      [] ->
        send_resp(conn, 404, "")

      posts ->
        response =
          posts
          |> Enum.map(&Post.to_hal_link/1)
          |> push_hal_links(conn)
          |> hal_link_list_to_collection_response
          |> Jason.encode!()

        send_resp(conn, 200, response)
    end
  end

  defp push_hal_links(list, conn) do
    Enum.each(list, fn %{"href" => link} ->
      push(conn, link)
    end)
    list
  end

  defp hal_link_list_to_collection_response(list) do
    %{
      "_links" => %{
        "self" => %{
          "href" => "/post/"
        },
        "items" => list
      }
    }
  end
end
