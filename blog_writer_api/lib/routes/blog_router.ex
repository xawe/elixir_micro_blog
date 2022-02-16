defmodule Routes.BlogRouter do
  use Routes.Base

  post "/create" do
    {status, data} = conn.body_params
    |> handle_payload()
    |>Service.Flow.handle_create_request()

    send(conn, status, data)
  end

  # forward "/movies", to: Routes.MovieRouter

  def handle_payload(%{"user" =>  u, "message" => m}) do
    IO.puts("User #{u}")
    IO.puts("Message #{m}")
    {:ok, %{user: u, message: m }}
  end

  def handle_payload(_) do
    IO.puts("Não tratado")
    {:malformed_data, %{message: "invalid payload"}}
  end

end
