use Mix.Config

config :app,
  redis_host: "redis://172.18.0.2:6379"

import_config "#{Mix.env()}.exs"
