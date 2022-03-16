defmodule App.Repo.Migrations.ChangePostDataType do
  use Ecto.Migration

  def change do
    alter table(:post) do
      modify :fingerprint, :bigint
    end
  end
end
