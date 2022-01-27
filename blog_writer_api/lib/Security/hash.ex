defmodule Security.Hash do

  def get_hash(value) do
    :crypto.hash(:sha, value)
      |> Base.encode16()
      |> Integer.parse(16)
  end
end
