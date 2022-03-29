defmodule Message.ConsumerImpl do
  require Logger

  @moduledoc """
  Modulo responsável pela implementação do consumo das mensagens recebidas da api de POst
  """

  @doc """
  Função responsavel por determinar o fluxo de consumo da mensagem.
  Recebe a mensagem e encaminha para o MessageFlow.process_data, responsável
  por persistir a mensagem no banco de dados.
  """
  def consume(channel, tag, redelivered, payload) do
    IO.inspect(payload)
    Logger.info("Mensagem processada em #{inspect Map.get(channel, :pid)}")
    Service.MessageFlow.process_data(payload)
    |> ack_message(channel, tag)
  rescue
    exception ->
      # :ok = Basic.reject(channel, tag, requeue: not redelivered)
      Logger.info("Rejeitando a mensagem #{payload}")
      ack_message({:error, ""}, channel, tag)
      Logger.info(Exception.format(:error, exception, __STACKTRACE__))
  end

  defp ack_message({:ok, _}, channel, tag) do
    :ok = AMQP.Basic.ack(channel, tag)
  end

  defp ack_message({_, _}, channel, tag) do
    :ok = AMQP.Basic.reject(channel, tag, requeue: false)
  end
end
