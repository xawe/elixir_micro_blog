defmodule Service.CacheProperty do
  def host() do
    Service.Property.get_app_prop(:redis_host)
  end

  def port() do
    Service.Property.get_app_prop(:redis_port)
  end
end
