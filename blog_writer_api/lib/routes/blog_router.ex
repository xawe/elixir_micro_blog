defmodule Routes.BlogRouter do
  use Routes.Base

  post "/create" do
    {status, data} =
      conn.body_params
      |> handle_payload()
      |> Service.Flow.handle_create_request()

    send(conn, status, data)
  end

  # forward "/movies", to: Routes.MovieRouter

  defp handle_payload(%{"user" => u, "message" => m}) do
    {:ok, %{user: u, message: m}}
  end

  defp handle_payload(_) do
    {:malformed_data, %{message: "invalid payload"}}
  end
end
