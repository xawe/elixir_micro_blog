defmodule Data.Cache do
  @doc """
  Adiciona um item na chave informada
    key - nome da chave
    value - o valor a ser inserido
  """
  def set(key, value) do
    Data.CacheServer.sadd(key, value)
    |> exists()
  end

  @doc """
  Verifica se a o valor indicado existe na chave informada;
  :ok se existir
  :none caso não encontre
  """
  def exists_set(key, value) do
    Data.CacheServer.sismember({key, value})
    |> exists()
  end

  @doc """
  Remove o valor da chave especificada
  :ok caso o valor seja removido com sucesso
  :none caso o valor não seja removido ou mesmo encontrado
  """
  def remove_value(key, value) do
    Data.CacheServer.srem({key, value})
    |> exists()
  end

  defp exists({_, 1}), do: :ok
  defp exists({_, 0}), do: :none
end
