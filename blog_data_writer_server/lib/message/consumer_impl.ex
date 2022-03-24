defmodule Message.ConsumerImpl do
  require Logger

  def consume(channel, tag, redelivered, payload) do
    Service.MessageFlow.process_data(payload)
    |> ack_message(channel, tag)
  rescue
    exception ->
      # :ok = Basic.reject(channel, tag, requeue: not redelivered)
      Logger.info(Exception.format(:error, exception, __STACKTRACE__))
  end

  defp ack_message({:ok, _}, channel, tag) do
    :ok = AMQP.Basic.ack(channel, tag)
  end

  defp ack_message({_, _}, channel, tag) do
    :ok = AMQP.Basic.reject(channel, tag, requeue: false)
  end
end
