defmodule Service.Property do


  def get_prop(key, prop_name) do
    Application.fetch_env!(key, prop_name)
  end

  def get_app_prop(prop_name) do
    get_prop(:app, prop_name)
  end

end
