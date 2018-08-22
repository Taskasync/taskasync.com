defmodule Taskasync.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :project_name, :string
      add :project_url, :string
      add :issue_url, :string
      add :status, :string, default: "UNASSIGNED"
      add :creator_id, references(:users, on_delete: :nothing)
      add :worker_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:creator_id])
    create index(:tasks, [:worker_id])
  end
end
