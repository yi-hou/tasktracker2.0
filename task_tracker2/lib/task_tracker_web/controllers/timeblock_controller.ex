defmodule TaskTrackerWeb.TimeblockController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Missions
  alias TaskTracker.Missions.Timeblock

  action_fallback TaskTrackerWeb.FallbackController

  def index(conn, _params) do
    timeblocks = Missions.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"timeblock" => timeblock_params}) do
    with {:ok, %Timeblock{} = timeblock} <- Missions.create_timeblock(timeblock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", timeblock_path(conn, :show, timeblock))
      |> render("show.json", timeblock: timeblock)
    end
  end

  def show(conn, %{"id" => id}) do
    timeblock = Missions.get_timeblock!(id)
    render(conn, "show.json", timeblock: timeblock)
  end

  def update(conn, %{"id" => id, "timeblock" => timeblock_params}) do
    timeblock = Missions.get_timeblock!(id)

    with {:ok, %Timeblock{} = timeblock} <- Missions.update_timeblock(timeblock, timeblock_params) do
      render(conn, "show.json", timeblock: timeblock)
    end
  end

  def delete(conn, %{"id" => id}) do
    timeblock = Missions.get_timeblock!(id)
    with {:ok, %Timeblock{}} <- Missions.delete_timeblock(timeblock) do
      send_resp(conn, :no_content, "")
    end
  end
end
