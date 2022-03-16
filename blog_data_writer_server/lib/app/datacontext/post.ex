defmodule App.DataContext.Post do
  import Ecto.Query, warn: false
  alias App.Repo

  alias App

  def create_post(attrs \\ %{}) do
    %App.Post{}
    |> App.Post.changeset(attrs)
    |> Repo.insert()
  end

end
