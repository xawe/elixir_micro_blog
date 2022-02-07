defmodule App.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: App.Worker.start_link(arg)
      # {App.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: port()]},
      #{Message.MessageServer, name: :message_server},
      {Redix, host: Service.Property.get_app_prop(:redis_host), port: Service.Property.get_app_prop(:redis_port) , name: :redix_conn},
      %{id: Data.CacheServer, start: {Data.CacheServer, :start_link, ["none"]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]

    IO.puts(Service.Property.get_app_prop(:redis_host))
    IO.puts("------------")
    Logger.info("The server listening at port: #{port()}")
    Supervisor.start_link(children, opts)
  end

  # Call environment variables here.
  defp port, do: Application.get_env(:app, :port, 8000)
end
