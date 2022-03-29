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
    AMQP.Exchange.declare(channel, Service.MessageProperty.receive_exchange(), :fanout,
      durable: true
    )

    AMQP.Exchange.declare(channel, Service.MessageProperty.confirm_exchange(), :fanout,
      durable: true
    )
  end

  @doc """
  Inicialização das filas
  """
  def queue_setups(channel) do
    AMQP.Queue.declare(channel, Service.MessageProperty.receive_queue(), durable: true)
    AMQP.Queue.declare(channel, Service.MessageProperty.persist_queue(), durable: true)
  end

  @doc """
  Inicialização de bindgs
  """
  def bind_setup(channel) do
    AMQP.Queue.bind(
      channel,
      Service.MessageProperty.receive_queue(),
      Service.MessageProperty.receive_exchange()
    )

    AMQP.Queue.bind(
      channel,
      Service.MessageProperty.persist_queue(),
      Service.MessageProperty.confirm_exchange()
    )
  end
end
