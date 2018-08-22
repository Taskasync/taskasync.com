defmodule Taskasync.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :description, :string
    field :project_name, :string
    field :project_url, :string
    field :status, :string
    field :issue_url, :string
    field :title, :string
    field :creator_id, :id
    field :worker_id, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :project_name, :project_url, :issue_url, :status])
    |> validate_required([:title, :description, :project_name, :project_url, :issue_url, :status])
  end
end
