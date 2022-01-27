defmodule Routes.BlogRouter do
  use Routes.Base


  post "/create" do
    IO.puts("OK ----- ")
    IO.inspect(conn.body_params)
    send(conn, :ok, conn.body_params)
  end


  #forward "/movies", to: Routes.MovieRouter

end
