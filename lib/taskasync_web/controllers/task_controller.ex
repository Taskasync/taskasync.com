defmodule TaskasyncWeb.TaskController do
  use TaskasyncWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", tasks: Taskasync.Tasks.list_tasks
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Taskasync.Tasks.change_task(%Taskasync.Tasks.Task{})
  end
end
