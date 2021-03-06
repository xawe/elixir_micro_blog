defmodule Service.CacheProperty do
  def host() do
    Service.Property.get_app_prop(:redis_host)
  end

  def port() do
    Service.Property.get_app_prop(:redis_port)
  end

  def cache_key() do
    "cachepayload"
  end

  def cache_status() do
    Service.Property.get_app_prop(:cache_status)
  end
end
