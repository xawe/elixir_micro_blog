defmodule App.Repo.Migrations.ChangePostDataType2 do
  use Ecto.Migration

  def change do
    alter table(:post) do
      modify :fingerprint, :string, null: false
    end
  end
end
