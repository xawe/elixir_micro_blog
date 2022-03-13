defmodule Message.Publisher do
  use GenServer
  require Logger
  alias Service.MessageProperty

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    {_, channel} = start_conn()
    build(channel)
    {:ok, channel}
  end

  def handle_call({:send, msg}, _from, channel) do
    result = AMQP.Basic.publish(channel, MessageProperty.exchange(), "", msg)
    {:reply, result, channel}
  end

  def handle_cast({:send_async, msg}, channel) do
    AMQP.Basic.publish(channel, MessageProperty.exchange(), "", msg)
    {:noreply, channel}
  end

  def send(msg) do
    GenServer.call(__MODULE__, {:send, msg})
  end

  def send_async(msg) do
    GenServer.cast(__MODULE__, {:send_async, msg})
  end

  defp start_conn() do
    Logger.info("Iniciando channel com message broker")
    AMQP.Application.get_channel(:msg_channel)
  end

  defp build(channel) do
    AMQP.Exchange.declare(channel, MessageProperty.exchange(), :fanout, durable: true)
    AMQP.Queue.declare(channel, MessageProperty.queue(), durable: true)
    AMQP.Queue.bind(channel, MessageProperty.queue(), MessageProperty.exchange())
    {:ok}
  end
end
