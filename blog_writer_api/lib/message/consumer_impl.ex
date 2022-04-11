defmodule Message.ConsumerImpl do
  require Logger

  @spec consume(any, any, any, any) :: any
  def consume(channel, tag, redelivered, payload) do
    IO.inspect(payload)
  end


  defp ack_message({:ok, data}, channel, tag) do
    :ok = AMQP.Basic.ack(channel, tag)
    {:ok, data}
  end

  defp ack_message({_, data}, channel, tag) do
    :ok = AMQP.Basic.reject(channel, tag, requeue: false)
    {:reject, data}
  end

end
