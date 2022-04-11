defmodule Message.PublisherApi do
  use GenServer
  use AMQP
  require Logger



  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(_) do
    {:ok, chan} = start_conn()
    {:ok, chan}
  end

  def handle_cast({:send_async, msg}, channel) do
    AMQP.Basic.publish(channel, Service.MessageProperty.confirm_exchange(), "", msg )
    {:noreply, channel}
  end

  def send_async(msg) do
    GenServer.cast(__MODULE__, {:send_async, msg})
  end

  defp start_conn() do
    Logger.info("Iniciando channel com message broker")
    AMQP.Application.get_channel(:msg_channel)
  end

end
