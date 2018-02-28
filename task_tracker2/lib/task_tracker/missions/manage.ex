defmodule TaskTracker.Missions.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Missions.Manage
  alias TaskTracker.Accounts.User

  schema "manages" do
    belongs_to :manager, User
    belongs_to :managee, User

    #field :manager_id, :id
    #field :managee_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:manager_id, :managee_id])
    |> validate_required([:manager_id, :managee_id])
  end
end
