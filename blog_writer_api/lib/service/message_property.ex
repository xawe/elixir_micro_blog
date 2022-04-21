defmodule Service.MessageProperty do
  @doc """
  Retorna o nome da exchange responsavel por armazenadas os dados recebidos via api
  """
  def receive_exchange() do
    Service.Property.get_app_prop(:receive_exchange)
  end

  @doc """
  Retorna o nome da exchange responsável pelas mensagens de confirmação de dados salvos
  """
  def confirm_exchange() do
    Service.Property.get_app_prop(:confirm_exchange)
  end

  @doc """
  retorna o nome da fila
  """
  def receive_queue() do
    Service.Property.get_app_prop(:receive_queue)
  end

  @doc """
  Retorna o nome da fila de persistencia
  """
  def persist_queue() do
    Service.Property.get_app_prop(:persist_queue)
  end

  @doc """
  retorna o nome da fila de erro
  """
  def error_queue() do
    Service.Property.get_app_prop(:error_queue)
  end

  @doc """
  Retorna o nome da fila de erro de persistencia
  """
  def persist_queue_error() do
    Service.Property.get_app_prop(:persist_queue_error)
  end

  def amqp_connection() do
    Application.get_env(:amqp, :connections)[:msg_conn][:url]
  end
end
