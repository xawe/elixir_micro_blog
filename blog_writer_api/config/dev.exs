import Config

# Development configurations goes here
config :app,
  port: 8000,
  redis_host: "red-cache",
  redis_port: 6379

# config :app ,
# redis_host: "redis://red-cache"

# Example of database configuration
# config :app, db_config: %{name: "dev_db", password: "", port: 10000}
