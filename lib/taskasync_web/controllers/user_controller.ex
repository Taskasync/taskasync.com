defmodule TaskasyncWeb.UserController do
  use TaskasyncWeb, :controller

  def new(conn, _params) do
    render conn, "new.html", changeset: Taskasync.Auth.change_user(%Taskasync.Auth.User{})
  end

  def create(conn, %{"user" => user_attrs}) do
    case Taskasync.Auth.create_user(user_attrs) do
      {:ok, user} ->
        conn
        |> TaskasyncWeb.Auth.login(user)
        |> put_flash(:info, "Welcome to Task.async")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There was a problem creating your account")
        |> render("new.html", changeset: changeset)
    end
  end
end
