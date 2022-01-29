defmodule Security.Hash do
  def get_hash(value) do
    :crypto.hash(:sha, value)
    |> Base.encode16()
    |> Integer.parse(16)
  end

  def get_hash_mur(value) do
    Murmur.hash_x86_128(value)
  end
end
