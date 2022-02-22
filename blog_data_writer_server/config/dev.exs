import Config

config :app, App.Repo,
  database: "blog_data_writer_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

  config :app, ecto_repos: [App.Repo]
