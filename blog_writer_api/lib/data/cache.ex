defmodule Data.Cache do
  def set(key, value) do
    Data.CacheServer.sadd(key, value)
    |> exists()
  end

  def exists_set(key, value) do
    Data.CacheServer.sismember({key, value})
    |> exists()
  end

  defp exists({_, 1}), do: :ok
  defp exists({_, 0}), do: :none
end
