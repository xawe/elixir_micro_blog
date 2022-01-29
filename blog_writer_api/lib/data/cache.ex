defmodule Data.Cache do
  def use_redix(data) do
    {:ok, conn} = Redix.start_link("redis://172.18.0.2:6379", name: :redix)
    result = Redix.command(conn, ["SADD", "post_cache", data])
    # result = Redix.command(conn, ["SET", "mykey", "foo"])
    result
  end
end
