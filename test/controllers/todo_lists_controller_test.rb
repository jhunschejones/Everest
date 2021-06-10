require 'test_helper'

# bundle exec ruby -Itest test/controllers/todo_lists_controller_test.rb
class TodoListsControllerTest < ActionDispatch::IntegrationTest
  describe "GET #index" do
    it "loads the project todo lists page" do
      get project_todo_lists_path(projects(:everest))
      assert_response :success
      assert_select "h1.project-todo-lists-title", "To-dos"
    end

    it "shows project todo list breadcrumbs" do
      get project_todo_lists_path(projects(:everest))
      assert_select "div.project-breadcrumb"
    end

    it "shows all the todo lists" do
      get project_todo_lists_path(projects(:everest))
      assert_select "div.todo-list", count: 2
    end

    it "shows all the todo list items" do
      get project_todo_lists_path(projects(:everest))
      assert_select "div.todo-item", count: 3
    end

    describe "without a project_id" do
      it "loads the project todo lists page" do
        get todo_lists_path
        assert_response :success
        assert_select "h1.project-todo-lists-title", "To-dos"
      end

      it "does not show project todo list breadcrumbs" do
        get todo_lists_path
        assert_select "div.project-breadcrumb", count: 0
      end

      it "shows all the todo lists" do
        get todo_lists_path
        assert_select "div.todo-list", count: 2
      end

      it "shows all the todo list items" do
        get todo_lists_path
        assert_select "div.todo-item", count: 3
      end
    end
  end

  describe "GET #show" do
    it "loads the project todo list page" do
      get project_todo_list_path(projects(:everest), todo_lists(:one))
      assert_response :success
      assert_select "h1.todo-list-title", todo_lists(:one).name
    end

    describe "when there are no todo list items" do
      before do
        todo_lists(:one).todo_items.destroy_all
      end

      it "does not show todo item count" do
        get project_todo_list_path(projects(:everest), todo_lists(:one))
        assert_select "p.completed-count", count: 0
      end

      it "does not show todo item pie chart" do
        get project_todo_list_path(projects(:everest), todo_lists(:one))
        assert_select "div.todo-list-pie-chart", count: 0
      end

      it "does not show todo list items" do
        get project_todo_list_path(projects(:everest), todo_lists(:one))
        assert_select "div.todo-item", count: 0
      end
    end

    describe "when there are todo list items" do
      it "shows todo item count" do
        get project_todo_list_path(projects(:everest), todo_lists(:one))
        assert_select "p.completed-count", "0 / 2 completed"
      end

      it "shows todo item pie chart" do
        get project_todo_list_path(projects(:everest), todo_lists(:one))
        assert_select "div.todo-list-pie-chart"
      end

      it "shows todo list items" do
        get project_todo_list_path(projects(:everest), todo_lists(:one))
        assert_select "div.todo-item", count: 2
      end
    end
  end

  describe "GET #new" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get new_project_todo_list_path(projects(:everest))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the new project todo list page" do
        get new_project_todo_list_path(projects(:everest))
        assert_response :success
        assert_select "h2.title", "New To-do List"
      end
    end
  end

  describe "GET #edit" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get edit_project_todo_list_path(projects(:everest), todo_lists(:one))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the edit project todo list page" do
        get edit_project_todo_list_path(projects(:everest), todo_lists(:one))
        assert_response :success
        assert_select "h2.title", "Edit To-do List"
        assert_select "input" do
          assert_select "[value=?]", todo_lists(:one).name
        end
      end
    end
  end

  describe "POST #create" do
    describe "when no user is logged in" do
      it "does not create a new project todo list" do
        assert_no_difference "TodoList.count" do
          post project_todo_lists_path(projects(:everest)), params: { todo_list: { name: "My new todo list" } }
        end
      end

      it "redirects to the login page page" do
        post project_todo_lists_path(projects(:everest)), params: { todo_list: { name: "My new todo list" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "creates a new project todo list" do
        assert_difference "TodoList.count", 1 do
          post project_todo_lists_path(projects(:everest)), params: { todo_list: { name: "My new todo list" } }
        end
        assert_equal "My new todo list", TodoList.last.name
      end

      it "redirects to the project todo list page" do
        post project_todo_lists_path(projects(:everest)), params: { todo_list: { name: "My new todo list" } }
        assert_redirected_to project_todo_list_path(projects(:everest), TodoList.last)
      end
    end
  end

  describe "PATCH #update" do
    describe "when no user is logged in" do
      it "does not update the project todo list record" do
        assert_no_changes -> { TodoList.find(todo_lists(:one).id).name } do
          patch project_todo_list_path(projects(:everest), todo_lists(:one)), params: { todo_list: { name: "Change the name" } }
        end
      end

      it "redirects to the login page page" do
        patch project_todo_list_path(projects(:everest), todo_lists(:one)), params: { todo_list: { name: "Change the name" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "updates the project todo list record" do
        assert_changes -> { TodoList.find(todo_lists(:one).id).name } do
          patch project_todo_list_path(projects(:everest), todo_lists(:one)), params: { todo_list: { name: "Change the name" } }
        end
        assert_equal "Change the name", TodoList.find(todo_lists(:one).id).name
      end

      it "redirects to the project todo list page" do
        patch project_todo_list_path(projects(:everest), todo_lists(:one)), params: { todo_list: { name: "Change the name" } }
        assert_redirected_to project_todo_list_path(projects(:everest), todo_lists(:one))
      end
    end
  end
end
