import Config

config :app,
  redis_host: "redis://172.24.0.2:6379"

import_config "#{Mix.env()}.exs"
