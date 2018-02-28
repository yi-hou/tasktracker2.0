defmodule TaskTracker.Missions.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Missions.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :time, :integer
    field :title, :string
    belongs_to :user, TaskTracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :time, :completed, :user_id])
    |> validate_required([:title, :description, :time, :completed, :user_id])
    |> validate_time(:time)
  end

  def validate_time(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, time ->
      if rem(time,15) == 0 do
         []
      else
         [{field, options[:message] || "Time has to increment by 15 minutes."}]
      end
    end)
  end
end
