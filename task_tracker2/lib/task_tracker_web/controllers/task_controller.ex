defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller
  require Logger

  alias TaskTracker.Missions
  alias TaskTracker.Missions.Task
  alias TaskTracker.Missions.Manage

  def index(conn, _params) do
    tasks = Missions.list_tasks()
    render(conn, "index.html", tasks: tasks, start: true)
  end

  def new(conn, _params) do
    changeset = Missions.change_task(%Task{})
    current_user = conn.assigns[:current_user]
    users = TaskTracker.Accounts.list_users()
    manageeIds = TaskTracker.Missions.manages_map_for(current_user.id)
    managees = Enum.map(Enum.map(manageeIds,
      fn u -> TaskTracker.Accounts.get_user!(elem(u,0)) end),
      fn u -> {u.name, u.id} end)

    render(conn, "new.html", changeset: changeset, start: true, managees: managees)
  end


  def create(conn, %{"task" => task_params}) do
    current_user = conn.assigns[:current_user]
    task_params = Map.put(task_params, "user_id", task_params["user_id"])
    case Missions.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: page_path(conn, :feed))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, start: true, managees: {})
    end
  end



  def show(conn, %{"id" => id}) do
    task = Missions.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Missions.get_task!(id)
    current_user = conn.assigns[:current_user]
    users = TaskTracker.Accounts.list_users()
    manageeIds = TaskTracker.Missions.manages_map_for(current_user.id)
    managees = Enum.map(Enum.map(manageeIds,
      fn u -> TaskTracker.Accounts.get_user!(elem(u,0)) end),
      fn u -> {u.name, u.id} end)
    changeset = Missions.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, managees: managees)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Missions.get_task!(id)

    case Missions.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Missions.get_task!(id)
    {:ok, _task} = Missions.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
