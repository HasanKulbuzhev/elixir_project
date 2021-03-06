defmodule Todo.TodoContext.TodoSchema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(todo_schema, attrs) do
    todo_schema
    |> cast(attrs, [:title, :description, :completed])
    |> validate_required([:title, :description, :completed])
  end
end
