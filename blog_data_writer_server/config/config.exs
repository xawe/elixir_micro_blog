import Config

config :app,
  receive_exchange: "receive_exchange",
  confirm_exchange: "confirm_exchange",
  receive_queue: "receive_data_queue",
  persist_queue: "persist_data_queue",
  error_queue: "post_data_queue_error",
  persist_queue_error: "persist_data_error",
  consumer_instance_count: "20"

config :app, App.Repo,
  database: "blog_data_writer_local",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 20

config :app, ecto_repos: [App.Repo]

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
