defmodule TaskasyncWeb.LayoutView do
  use TaskasyncWeb, :view

  def is_active(current_path, test) when current_path == test, do: "active"
  def is_active(_, _), do: ""
end
