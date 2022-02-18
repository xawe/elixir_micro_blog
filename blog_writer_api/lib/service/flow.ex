defmodule Service.Flow do
  alias Service.CacheProperty
  require Logger

  @moduledoc """
  Modulo responsável por orquestrar o envio de mensagem

    1 - criação do hash da mensagem    
    2 - enviar hash para o cache
    3 - Caso a mensagem não exista no cache, ela seguirá para a exchange para propagação da informação

  """

  @doc """
    função responsável por determinar o fluxo da mensagem recebida         
  """
  def handle_create_request({:ok, payload}) do
    hash = Security.Hash.get_hash_mur(payload)
    created = Data.Cache.set(CacheProperty.cache_key(), hash)
    send_data({created, hash, payload})

    {:ok, payload}
  end

  def handle_create_request(data) do
    IO.puts("Not handled input")
    IO.inspect(data)
    data
  end

  defp send_data({:ok, hash, payload}) do
    Logger.info("Sending data to exchange --- #{hash}")

    build_message(payload, hash)
    |> Jason.encode!()
    |> Message.Publisher.send_async()

    :noreply
  end

  defp send_data({status, hash, _}) do
    IO.puts("This not sent -- status #{status} --- hash -  #{hash}")
    :error
  end

  defp build_message(payload, hash) do
    %{id: UUID.uuid1(), created_on: DateTime.utc_now(), fingerprint: hash, message: payload}
  end
end
