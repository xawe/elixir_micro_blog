defmodule Service.MessageProperty do
  @doc """
  Retorna o nome da exchange
  """
  def exchange() do
    Service.Property.get_app_prop(:exchange)
  end

  @doc """
  retorna o nome da fila
  """
  def queue() do
    Service.Property.get_app_prop(:queue)
  end

  def queue_in() do
    Service.Property.get_app_prop(:queue_in)
  end

  @doc """
  retorna o nome da fila de erro
  """
  def error_queue() do
    Service.Property.get_app_prop(:error_queue)
  end

  @doc """
  retorna a quantidade de instancias para o consumidor da fila
  """
  def consumer_instance_count() do
    {v, _} = Service.Property.get_app_prop(:consumer_instance_count)
    |> Integer.parse
    v
  end

  def amqp_connection() do
    Application.get_env(:amqp, :connections)[:msg_conn][:url]
  end
end
