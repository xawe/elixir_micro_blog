defmodule Message.Consumer do
  use GenServer
  use AMQP
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, [], [])
  end

  # @exchange "gen_server_test_exchange"
  # @queue "gen_server_test_queue"
  # @queue_error "#{@queue}_error"

  def init(_opts) do
    {:ok, conn} = Connection.open("amqp://guest:guest@localhost")
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

  # não utilizado.
  defp setup_queue(chan) do
    IO.inspect("------------")
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
  rescue
    exception ->
      # :ok = Basic.reject(channel, tag, requeue: not redelivered)
      IO.inspect(Exception.format(:error, exception, __STACKTRACE__))
  end
end
