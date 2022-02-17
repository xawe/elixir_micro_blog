defmodule Service.Flow do
  alias Service.CacheProperty

  def handle_create_request({:ok, payload}) do
    CacheProperty.cache_key()
    |> Data.Cache.set(Security.Hash.get_hash_mur(payload))
    |> persist_data(payload)

    # IO.puts("Hash created? >> #{exists}")
    {:ok, payload}
  end

  def handle_create_request(data) do
    IO.puts("Not handled input")
    IO.inspect(data)
    data
  end

  defp persist_data(:ok, payload) do
    IO.puts("Sending data to exchange")

    payload
    |> Jason.encode!()
    |> Message.Publisher.send_async()

    :noreply
  end

  defp persist_data(status, _) do
    IO.puts("Breaking chain --- #{status}")
    :error
  end
end
