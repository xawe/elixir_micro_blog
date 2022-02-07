defmodule Message.MessageServer do
  use GenServer
  require Logger

def start_link(_) do
  GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
end

def init(_) do
  {:ok, connection} = AMQP.Connection.open()
  Logger.info("Starting AMQP Connection")
  {:ok, channel} = AMQP.Channel.open(connection)
  Logger.info(channel)
  {:ok, channel}
end

end
