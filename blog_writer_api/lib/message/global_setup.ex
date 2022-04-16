defmodule Message.GlobalSetup do
  require Logger

  @moduledoc """
  Responsável por inicializar a infraestrutura de Exchanges e Filas
  """
  def init(channel) do
    exchanges_setup(channel)
    queue_setups(channel)
    bind_setup(channel)
    {:ok}
  end

  @doc """
  Inicializa as exchanges usadas no sistema
  """
  def exchanges_setup(channel) do
    Logger.info("------------")
    Logger.info("Inicializando Exchanges")

    AMQP.Exchange.declare(channel, Service.MessageProperty.receive_exchange(), :fanout,
      durable: true
    )

    Logger.info("#{Service.MessageProperty.receive_exchange()} - OK")

    AMQP.Exchange.declare(channel, Service.MessageProperty.confirm_exchange(), :fanout,
      durable: true
    )

    Logger.info("#{Service.MessageProperty.confirm_exchange()} - OK")
  end

  @doc """
  Inicialização das filas
  """
  def queue_setups(channel) do
    Logger.info("------------")
    Logger.info("Inicializando Queues")
    AMQP.Queue.declare(channel, Service.MessageProperty.receive_queue(), durable: true)
    Logger.info("#{Service.MessageProperty.receive_queue()} - OK")
    AMQP.Queue.declare(channel, Service.MessageProperty.persist_queue(), durable: true)
    Logger.info("#{Service.MessageProperty.persist_queue()} - OK")
  end

  @doc """
  Inicialização de bindgs
  """
  def bind_setup(channel) do
    Logger.info("------------")
    Logger.info("Inicializando Binds")

    AMQP.Queue.bind(
      channel,
      Service.MessageProperty.receive_queue(),
      Service.MessageProperty.receive_exchange()
    )

    Logger.info(
      "#{Service.MessageProperty.receive_queue()}  X #{Service.MessageProperty.receive_exchange()} - OK"
    )

    AMQP.Queue.bind(
      channel,
      Service.MessageProperty.persist_queue(),
      Service.MessageProperty.confirm_exchange()
    )

    Logger.info(
      "#{Service.MessageProperty.persist_queue()}  X #{Service.MessageProperty.confirm_exchange()} - OK"
    )
  end
end
