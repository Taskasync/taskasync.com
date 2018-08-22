defmodule Taskasync.TasksTest do
  use Taskasync.DataCase

  alias Taskasync.Tasks

  describe "tasks" do
    alias Taskasync.Tasks.Task

    @valid_attrs %{description: "some description", project_name: "some project_name", project_url: "some project_url", status: "some status", ticket_url: "some ticket_url", title: "some title"}
    @update_attrs %{description: "some updated description", project_name: "some updated project_name", project_url: "some updated project_url", status: "some updated status", ticket_url: "some updated ticket_url", title: "some updated title"}
    @invalid_attrs %{description: nil, project_name: nil, project_url: nil, status: nil, ticket_url: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tasks.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tasks.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.project_name == "some project_name"
      assert task.project_url == "some project_url"
      assert task.status == "some status"
      assert task.ticket_url == "some ticket_url"
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Tasks.update_task(task, @update_attrs)
      
      assert task.description == "some updated description"
      assert task.project_name == "some updated project_name"
      assert task.project_url == "some updated project_url"
      assert task.status == "some updated status"
      assert task.ticket_url == "some updated ticket_url"
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
