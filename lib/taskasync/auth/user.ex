defmodule Taskasync.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string

    field :current_password, :string, virtual: true
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def register_changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end

  def change_password_changeset(user, attrs) do
    if Comeonin.Pbkdf2.checkpw(user.password_hash, attrs["password"]) do
      user
      |> cast(attrs, [:password])
      |> validate_required([:password])
      |> put_pass_hash()
    else
      add_error(user, :current_password, "Invalid password")
    end
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))
  end
  defp put_pass_hash(changeset), do: changeset

end
