defmodule HashTest do
  use ExUnit.Case

  test "simple 123" do
    {r, _} = Security.Hash.get_hash("123")
    assert r == 369590257452814774925548805240102185537183137519
  end

  test "simple Alam name test" do
    {r, _} = Security.Hash.get_hash("Alam Martins")
    assert r == 1277209514209587487462553690522780865937379794683
  end

end