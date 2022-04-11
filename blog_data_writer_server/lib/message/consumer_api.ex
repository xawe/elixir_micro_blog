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
    {:ok, _consumer_tag} = Basic.consume(chan, Service.MessageProperty.receive_queue())
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

  def count_children() do
    DynamicSupervisor.count_children()
  end

  ## não utilizado. falta implementar a postagem da mensagem para a fila de sincronização
  # defp setup_queue(chan) do
  #   IO.inspect(Service.MessageProperty.error_queue())
  #   {:ok, _} = Queue.declare(chan, Service.MessageProperty.error_queue(), durable: true)

  #   {:ok, _} =
  #     Queue.declare(chan, Service.MessageProperty.queue_in(),
  #       durable: true,
  #       arguments: [
  #         {"x-dead-letter-exchange", :longstr, ""},
  #         {"x-dead-letter-routing-key", :longstr, Service.MessageProperty.error_queue()}
  #       ]
  #     )

  #   IO.inspect("------------")
  #   IO.inspect(Service.MessageProperty.exchange())
  #   :ok = Exchange.fanout(chan, Service.MessageProperty.exchange(), durable: true)
  #   :ok = Queue.bind(chan, Service.MessageProperty.queue_in(), Service.MessageProperty.exchange())
  # end
end
