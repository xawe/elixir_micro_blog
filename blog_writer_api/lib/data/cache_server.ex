defmodule Data.CacheServer do
  use GenServer
  require Logger

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:sadd, {key, value}}, _from, _) do
    result = Redix.command(:redix_conn, ["SADD", key, value])
    {:reply, result, []}
  end

  def handle_call({:sismember, {key, value}}, _from, _) do
    result = Redix.command(:redix_conn, ["SISMEMBER", key, value])
    {:reply, result, []}
  end

  def handle_call({:srem, {key, value}}, _from, _) do
    result = Redix.command(:redix_conn, ["SREM", key, value])
    {:reply, result, []}
  end

  @spec sadd(any, any) :: any
  def sadd(key, value) do
    GenServer.call(__MODULE__, {:sadd, {key, value}})
  end

  def sismember({key, value}) do
    GenServer.call(__MODULE__, {:sismember, {key, value}})
  end

  def srem({key, value}) do
    GenServer.call(__MODULE__, {:srem, {key, value}})
  end
end
