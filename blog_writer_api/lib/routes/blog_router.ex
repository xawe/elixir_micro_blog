defmodule Routes.BlogRouter do
  use Routes.Base


  post "/create" do
    body = conn.body_params

    send(conn, :ok, conn.body_params)
  end


  #forward "/movies", to: Routes.MovieRouter

end
