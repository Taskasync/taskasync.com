defmodule TaskasyncWeb.PageController do
  use TaskasyncWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", tasks: Taskasync.Tasks.list_tasks(:oldest)
  end

  def how_it_works(conn, _params) do
    render conn, "index.html", tasks: Taskasync.Tasks.list_tasks(:oldest)
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
end
