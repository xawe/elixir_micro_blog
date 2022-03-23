import Config

config :app,
  exchange: "persist_data_ex",
  queue_in: "post_data_ok",
  queue: "persist_data_ok",
  error_queue: "persist_data_error",
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
