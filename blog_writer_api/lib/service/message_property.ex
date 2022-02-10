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

  @doc """
  retorna o nome da fila de erro
  """
  def error_queue() do
    Service.Property.get_app_prop(:error_queue)
  end
end
