import Config

config :app,
  # redis_host: "redis://172.24.0.2:6379"
  redis_host: "localhost",
  redis_port: 6379,
  exchange: "post_data_ex",
  queue: "post_data_ok",
  error_queue: "post_data_error",
  cache_status: :off

config :amqp,
  connections: [
    msg_conn: [url: "amqp://guest:guest@localhost:5672"]
  ],
  channels: [
    msg_channel: [
      connection: :msg_conn
    ]
  ]

import_config "#{Mix.env()}.exs"
