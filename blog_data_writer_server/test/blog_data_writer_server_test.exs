defmodule BlogDataWriterServerTest do
  use ExUnit.Case
  doctest BlogDataWriterServer

  test "greets the world" do
    assert BlogDataWriterServer.hello() == :world
  end
end
