defmodule Service.Flow do
  alias Service.CacheProperty


  def handle_create_request(body) do
    hash = Security.Hash.get_hash_mur(body)
    IO.puts("HASH >> #{hash}")
    exists = Data.Cache.set(CacheProperty.cache_key() , hash)
    IO.puts("Hash created? >> #{exists}")
    exists
  end
end
