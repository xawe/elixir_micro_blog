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
    {:ok, conn} = get_conn()
    result = Redix.command(conn, ["SADD", key, value])
    Redix.stop(conn)
    {:reply, result, []}
  end

  def handle_call({:sismember, {key, value}}, _from, _) do
    {:ok, conn} = get_conn()
    result = Redix.command(conn, ["SISMEMBER", key, value])
    Redix.stop(conn)
    {:reply, result, []}
  end

  @spec sadd(any, any) :: any
  def sadd(key, value) do
    GenServer.call(__MODULE__, {:sadd, {key, value}})
  end

  def sismember({key, value}) do
    GenServer.call(__MODULE__, {:sismember, {key, value}})
  end

  defp get_conn() do
    url = Service.Property.get_app_prop(:redis_host)
    Logger.info("Connecting #{url}")
    Redix.start_link(url, name: :redix)
  end
end
