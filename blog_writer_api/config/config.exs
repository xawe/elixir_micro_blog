import Config

config :app,
  # redis_host: "redis://172.24.0.2:6379"
  redis_host: "172.24.0.2",
  redis_port: 6379

import_config "#{Mix.env()}.exs"
