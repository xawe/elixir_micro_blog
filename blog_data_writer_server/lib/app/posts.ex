defmodule App.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post" do
    field :user, :string
    field :message, :string
    field :referenceid, :string
    field :fingerprint, :integer

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:user, :message, :referenceid, :fingerprint])
    |> validate_required([:user, :message, :referenceid, :fingerprint])
  end

end
