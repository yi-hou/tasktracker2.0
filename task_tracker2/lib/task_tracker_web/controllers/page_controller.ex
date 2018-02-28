defmodule TaskTrackerWeb.PageController do
  use TaskTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Enum.reverse(TaskTracker.Missions.feed_posts_for(conn.assigns[:current_user]))

    changeset = TaskTracker.Missions.change_task(%TaskTracker.Missions.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
