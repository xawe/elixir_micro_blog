defmodule Service.Flow do
  alias Service.CacheProperty

  def handle_create_request({:ok, pay}) do
    hash = Security.Hash.get_hash_mur(pay)
    IO.puts("HASH >> #{hash}")
    exists = Data.Cache.set(CacheProperty.cache_key() , hash)
    IO.puts("Hash created? >> #{exists}")
    {:ok, pay}
  end

  def handle_create_request(data) do
    IO.inspect(data)
    data
  end
end
