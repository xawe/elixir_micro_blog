defmodule Service.Flow do

  @cache_key "input_cache_key"

  def handle_create_request(body) do
    hash = Security.Hash.get_hash_mur(body)
    IO.puts("HASH >> #{hash}")
    exists = Data.Cache.set(@cache_key, hash)
    IO.inspect(exists)
    exists
  end
end
