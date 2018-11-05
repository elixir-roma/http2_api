defmodule Http2ApiTest do
  use ExUnit.Case
  doctest Http2Api

  test "greets the world" do
    assert Http2Api.hello() == :world
  end
end
