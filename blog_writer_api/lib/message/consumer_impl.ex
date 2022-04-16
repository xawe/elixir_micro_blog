defmodule Message.ConsumerImpl do
  require Logger

  @spec consume(any, any, any, any) :: any
  def consume(channel, tag, _redelivered, payload) do
    Logger.info("Removing Hash from cache >> #{payload}")

    fingerprint =
      payload
      |> Jason.decode()
      |> get_fingerprint()

    Data.Cache.remove_value(Service.CacheProperty.cache_key(), fingerprint)
    |> ack_message(fingerprint, channel, tag)
  end

  defp ack_message(:ok, data, channel, tag) do
    Logger.info("Success removing message #{data}")
    :ok = AMQP.Basic.ack(channel, tag)
    {:ok, data}
  end

  defp ack_message(_, data, channel, tag) do
    Logger.info("This message will not be removed #{data}")
    :ok = AMQP.Basic.reject(channel, tag, requeue: false)
    {:reject, data}
  end

  defp get_fingerprint({_status, message}) do
    Map.get(message, "fingerprint")
  end
end
