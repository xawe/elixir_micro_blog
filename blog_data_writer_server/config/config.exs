import Config

config :app, App.Repo,
  database: "blog_data_writer_local",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

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
