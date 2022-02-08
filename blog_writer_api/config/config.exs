import Config

config :app,
  # redis_host: "redis://172.24.0.2:6379"
  redis_host: "172.24.0.2",
  redis_port: 6379

config :amqp,
  connections: [
    myconn: [url: "amqp://guest:guest@172.24.0.3:5672"],
  ],
  channels: [
    mychan: [connection: :myconn]
  ]

import_config "#{Mix.env()}.exs"
