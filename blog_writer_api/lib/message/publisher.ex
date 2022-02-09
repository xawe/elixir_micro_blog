defmodule Message.Publisher do
  use GenServer
  require Logger
  alias Service.MessageProperty

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    {_, channel} = start_conn()
    {:ok, channel}
  end

  defp start_conn() do
    Logger.info("Iniciando channel com message broker")
    AMQP.Application.get_channel(:msg_channel)
  end

  defp build_msg_infra(channel) do
    AMQP.Exchange.declare(channel, MessageProperty.exchange, :fanout)
    AMQP.Queue.declare(channel, MessageProperty.queue, [:durable])
    AMQP.Queue.declare(channel, MessageProperty.error_queue, [:durable])
  end
end
