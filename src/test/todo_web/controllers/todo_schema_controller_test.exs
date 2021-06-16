defmodule TodoWeb.TodoSchemaControllerTest do
  use TodoWeb.ConnCase

  alias Todo.TodoContext

  @create_attrs %{completed: true, description: "some description", title: "some title"}
  @update_attrs %{completed: false, description: "some updated description", title: "some updated title"}
  @invalid_attrs %{completed: nil, description: nil, title: nil}

  def fixture(:todo_schema) do
    {:ok, todo_schema} = TodoContext.create_todo_schema(@create_attrs)
    todo_schema
  end

  describe "index" do
    test "lists all todos", %{conn: conn} do
      conn = get(conn, Routes.todo_schema_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Todos"
    end
  end

  describe "new todo_schema" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.todo_schema_path(conn, :new))
      assert html_response(conn, 200) =~ "New Todo schema"
    end
  end

  describe "create todo_schema" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.todo_schema_path(conn, :create), todo_schema: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.todo_schema_path(conn, :show, id)

      conn = get(conn, Routes.todo_schema_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Todo schema"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.todo_schema_path(conn, :create), todo_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Todo schema"
    end
  end

  describe "edit todo_schema" do
    setup [:create_todo_schema]

    test "renders form for editing chosen todo_schema", %{conn: conn, todo_schema: todo_schema} do
      conn = get(conn, Routes.todo_schema_path(conn, :edit, todo_schema))
      assert html_response(conn, 200) =~ "Edit Todo schema"
    end
  end

  describe "update todo_schema" do
    setup [:create_todo_schema]

    test "redirects when data is valid", %{conn: conn, todo_schema: todo_schema} do
      conn = put(conn, Routes.todo_schema_path(conn, :update, todo_schema), todo_schema: @update_attrs)
      assert redirected_to(conn) == Routes.todo_schema_path(conn, :show, todo_schema)

      conn = get(conn, Routes.todo_schema_path(conn, :show, todo_schema))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, todo_schema: todo_schema} do
      conn = put(conn, Routes.todo_schema_path(conn, :update, todo_schema), todo_schema: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Todo schema"
    end
  end

  describe "delete todo_schema" do
    setup [:create_todo_schema]

    test "deletes chosen todo_schema", %{conn: conn, todo_schema: todo_schema} do
      conn = delete(conn, Routes.todo_schema_path(conn, :delete, todo_schema))
      assert redirected_to(conn) == Routes.todo_schema_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.todo_schema_path(conn, :show, todo_schema))
      end
    end
  end

  defp create_todo_schema(_) do
    todo_schema = fixture(:todo_schema)
    %{todo_schema: todo_schema}
  end
end
