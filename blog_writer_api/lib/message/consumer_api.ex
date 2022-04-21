defmodule Message.ConsumerApi do
  use GenServer
  use AMQP
  require Logger

  def start_link(process_name) do
    GenServer.start_link(__MODULE__, {process_name}, name: {:global, "server:#{process_name}"})
  end

  def init(_opts) do
    {:ok, conn} = Connection.open(Service.MessageProperty.amqp_connection())
    {:ok, chan} = Channel.open(conn)
    :ok = Basic.qos(chan, prefetch_count: 10)
    {:ok, _consumer_tag} = Basic.consume(chan, Service.MessageProperty.persist_queue())
    {:ok, chan}
  end

  def handle_info({:basic_consume_ok, %{consumer_tag: _}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_cancel, %{consumer_tag: _}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_cancel_ok, %{consumer_tag: _}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_deliver, payload, %{delivery_tag: tag, redelivered: redelivered}}, chan) do
    Message.ConsumerImpl.consume(chan, tag, redelivered, payload)
    {:noreply, chan}
  end
end
