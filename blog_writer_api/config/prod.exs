import Config

# Production configuration goes here.
config :app, port: 8000,
#redis_host: "redis://172.24.0.2:6379",
redis_host: "red-cache",
redis_port: 6379
