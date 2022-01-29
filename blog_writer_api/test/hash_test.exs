defmodule HashTest do
  use ExUnit.Case

  test "simple 123" do
    {r, _} = Security.Hash.get_hash("123")
    assert r == 369_590_257_452_814_774_925_548_805_240_102_185_537_183_137_519
  end

  test "simple Alam name test" do
    {r, _} = Security.Hash.get_hash("Alam Martins")
    assert r == 1_277_209_514_209_587_487_462_553_690_522_780_865_937_379_794_683
  end

  test "Murmur Hash 128 test" do
    r = Security.Hash.get_hash_mur("Alam Martins")
    assert r == 325_079_386_751_010_899_307_083_330_019_714_262_487
  end
end
