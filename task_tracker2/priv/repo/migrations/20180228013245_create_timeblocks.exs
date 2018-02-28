defmodule TaskTracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime

      timestamps()
    end

  end
end
