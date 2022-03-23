defmodule Message.Consumer do
  use GenServer
  use AMQP
  require Logger

  def start_link(process_name) do
    GenServer.start_link(__MODULE__, {process_name}, name: {:global, "server:#{process_name}"})
  end

  def init(_opts) do
    {:ok, conn} = Connection.open(Service.MessageProperty.amqp_connection())
    {:ok, chan} = Channel.open(conn)
    # setup_queue(chan)

    :ok = Basic.qos(chan, prefetch_count: 10)
    {:ok, _consumer_tag} = Basic.consume(chan, Service.MessageProperty.queue_in())
    {:ok, chan}
  end

  def handle_info({:basic_consume_ok, %{consumer_tag: consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_cancel, %{consumer_tag: consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_cancel_ok, %{consumer_tag: consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_deliver, payload, %{delivery_tag: tag, redelivered: redelivered}}, chan) do
    consume(chan, tag, redelivered, payload)
    {:noreply, chan}
  end

  def count_children() do
    DynamicSupervisor.count_children()
  end

  ## não utilizado. falta implementar a postagem da mensagem para a fila de sincronização
  defp setup_queue(chan) do
    IO.inspect(Service.MessageProperty.error_queue())
    {:ok, _} = Queue.declare(chan, Service.MessageProperty.error_queue(), durable: true)

    {:ok, _} =
      Queue.declare(chan, Service.MessageProperty.queue_in(),
        durable: true,
        arguments: [
          {"x-dead-letter-exchange", :longstr, ""},
          {"x-dead-letter-routing-key", :longstr, Service.MessageProperty.error_queue()}
        ]
      )

    IO.inspect("------------")
    IO.inspect(Service.MessageProperty.exchange())
    :ok = Exchange.fanout(chan, Service.MessageProperty.exchange(), durable: true)
    :ok = Queue.bind(chan, Service.MessageProperty.queue_in(), Service.MessageProperty.exchange())
  end

  defp consume(channel, tag, redelivered, payload) do
    Service.MessageFlow.process_data(payload)
      |> release_message(channel, tag)

      Logger.info("Message process in #{__MODULE__}")
  rescue
    exception ->
      # :ok = Basic.reject(channel, tag, requeue: not redelivered)
      IO.inspect(Exception.format(:error, exception, __STACKTRACE__))
  end

  defp release_message({:ok, _}, channel, tag) do
    :ok = AMQP.Basic.ack(channel, tag)
  end

  defp release_message({_, _}, channel, tag) do
    :ok = AMQP.Basic.reject(channel, tag, requeue: false)
  end
end
