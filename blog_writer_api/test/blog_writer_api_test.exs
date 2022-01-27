defmodule BlogWriterApiTest do
  use ExUnit.Case
  doctest BlogWriterApi

  test "greets the world" do
    assert BlogWriterApi.hello() == :world

  end
end
