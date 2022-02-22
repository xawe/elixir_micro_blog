import Config

config :app, Friends.Repo,
  database: "blog_data_writer",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

import_config "#{Mix.env()}.exs"
