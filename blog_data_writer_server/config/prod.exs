import Config

config :app, App.Repo,
database: "blog_data_writer",
username: "postgres",
password: "postgres",
hostname: "red-data-in"

config :app, ecto_repos: [App.Repo]

config :amqp,
  connections: [
    msg_conn: [url: "amqp://guest:guest@red-rabbit:5672"]
  ],
  channels: [
    msg_channel: [
      connection: :msg_conn
    ]
  ]
