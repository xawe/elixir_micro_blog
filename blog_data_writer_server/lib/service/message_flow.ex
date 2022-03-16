defmodule Service.MessageFlow do
  require Logger

  def process_data(payload) do
    {status, data} =
      payload
      |> Jason.decode()
      |> build_message_map
      |> App.DataContext.Post.create_post()

    id = Map.get(data, :id)
    Logger.info("Dados armazenados com sucesso :: id #{id}")
    {status, data}

  end

  defp build_message_map({status, message}) do
    message_content = Map.get(message, "message")

    %{
      fingerprint: Integer.to_string(Map.get(message, "fingerprint")),
      referenceid: Map.get(message, "id"),
      user: Map.get(message_content, "user"),
      message: Map.get(message_content, "message")
    }
  end
end
