defmodule App.Post do
  use Ecto.Schema

  schema "post" do
    field :user, :string
    field :message, :string
    field :referenceid, :string
    field :fingerprint, :integer

    timestamps()
  end
end
