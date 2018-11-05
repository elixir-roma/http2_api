defmodule Http2Api.Post.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field(:title, :string)
    field(:content, :string)

    timestamps()
  end

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, [:title, :content])
    |> validate_required([:title, :content])
  end

  def to_response(%__MODULE__{} = post) do
    post
    |> Map.from_struct()
    |> Map.delete(:__meta__)
    |> Map.put("_links", %{
      "self" => to_hal_link(post)
    })
  end

  def to_hal_link(%__MODULE__{} = post) do
    %{
      "href" => "/post/#{post.id}"
    }
  end
end
