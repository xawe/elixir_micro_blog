defmodule Service.MessageProperty do
  def queue() do
    Service.Property.get_app_prop(:queue)
  end

  def error_queue() do
    Service.Property.get_app_prop(:error_queue)
  end
end
