defmodule Message.MessageSupervisor do
  use DynamicSupervisor

  def start_link(_args) do
    sup = DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
    #Supervisor.start_child(__MODULE__, [Message.Consumer])
    build_process(10)
    sup
  end

  def init(_) do
    #Supervisor.init([Message.Consumer], strategy: :one_for_one)
    DynamicSupervisor.init( strategy: :one_for_one)
  end

  defp build_process(count) do
    items = 0..count
    Enum.each(items, fn x -> create_process(x) end)
  end

  defp create_process(name) do
    child_spec = {Message.Consumer, name}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

end
