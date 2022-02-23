defmodule App.Repo.Migrations.UserPost do
  use Ecto.Migration

  def change do
    create table(:post) do
      add :message, :string, null: false
      add :user, :string, null: false
      add :referenceid, :string, null: false
      add :fingerprint, :integer

      timestamps()
    end

  end
end
