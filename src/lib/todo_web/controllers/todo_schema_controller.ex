defmodule TodoWeb.TodoSchemaController do
  use TodoWeb, :controller

  alias Todo.TodoContext
  alias Todo.TodoContext.TodoSchema

  def index(conn, _params) do
    todos = TodoContext.list_todos()
    render(conn, "index.html", todos: todos)
  end

  def new(conn, _params) do
    changeset = TodoContext.change_todo_schema(%TodoSchema{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo_schema" => todo_schema_params}) do
    case TodoContext.create_todo_schema(todo_schema_params) do
      {:ok, todo_schema} ->
        conn
        |> put_flash(:info, "Todo schema created successfully.")
        |> redirect(to: Routes.todo_schema_path(conn, :show, todo_schema))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo_schema = TodoContext.get_todo_schema!(id)
    render(conn, "show.html", todo_schema: todo_schema)
  end

  def edit(conn, %{"id" => id}) do
    todo_schema = TodoContext.get_todo_schema!(id)
    changeset = TodoContext.change_todo_schema(todo_schema)
    render(conn, "edit.html", todo_schema: todo_schema, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo_schema" => todo_schema_params}) do
    todo_schema = TodoContext.get_todo_schema!(id)

    case TodoContext.update_todo_schema(todo_schema, todo_schema_params) do
      {:ok, todo_schema} ->
        conn
        |> put_flash(:info, "Todo schema updated successfully.")
        |> redirect(to: Routes.todo_schema_path(conn, :show, todo_schema))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo_schema: todo_schema, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo_schema = TodoContext.get_todo_schema!(id)
    {:ok, _todo_schema} = TodoContext.delete_todo_schema(todo_schema)

    conn
    |> put_flash(:info, "Todo schema deleted successfully.")
    |> redirect(to: Routes.todo_schema_path(conn, :index))
  end
end
