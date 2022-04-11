defmodule Message.MessageSupervisor do
  use DynamicSupervisor

  require Logger

  def start_link(_args) do
    sup = DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
    DynamicSupervisor.start_child(__MODULE__, {Message.ConsumerApi, :stored_data_server})
    sup
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
