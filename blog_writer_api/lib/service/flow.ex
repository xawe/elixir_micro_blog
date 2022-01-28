defmodule Service.Flow do

  def handle_create_request(body) do
    hash = Security.Hash.get_hash_mur(body)

  end
end
