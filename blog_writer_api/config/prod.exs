import Config

# Production configuration goes here.
config :app,
  port: 8000,
  # redis_host: "redis://172.24.0.2:6379",
  redis_host: "red-cache",
  redis_port: 6379

# config :amqp,
# connections: [
#   msg_conn: [url: "amqp://guest:guest@red-rabbit:5672"],
# ],
# channels: [
#   msg_channel: [
#     connection: :msg_conn,
#   ]
# ]
