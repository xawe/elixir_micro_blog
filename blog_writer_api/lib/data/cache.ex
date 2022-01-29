defmodule Data.Cache do
  def use_redix(data) do
    {:ok, conn} = Redix.start_link("redis://172.18.0.2:6379", name: :redix)
    result = Redix.command(conn, ["SADD", "post_cache", data])
    result
  end

  def set(key, value) do
    Data.CacheServer.sadd(key, value)
  end

  def exists_set(key, value) do
    Data.CacheServer.sismember({key, value})
    |> exists()
  end

  defp exists(1), do: :ok
  defp exists(0), do: :none
end
