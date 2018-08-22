defmodule Taskasync.Repo do
  use Ecto.Repo,
    otp_app: :taskasync,
    adapter: Ecto.Adapters.Postgres
end
