defmodule Routes.ApiRouter do
  use Routes.Base

  @database [%{"id" => 1, "title" => "Hello"}, %{"id" => 2, "title" => "world!"}]

  get "/" do
    send(conn, 200, @database)
  end

  post "/" do
    IO.puts("OK ----- ")
    IO.inspect(conn.body_params)
    send(conn, :ok, %{"id" => 3, "title" => "just been added"})
  end

  put "/:id" do
    send(conn, :ok, %{"id" => id, "title" => "Just been updated"})
  end

  delete "/:id" do
    send(conn, :ok, %{"id" => id, "title" => "Just been deleted"})
  end

  # forward "/movies", to: Routes.MovieRouter
  forward("/blog", to: Routes.BlogRouter)
end
