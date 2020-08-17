require 'test_helper'

# bundle exec ruby -Itest test/controllers/todo_items_controller_test.rb
class TodoItemsControllerTest < ActionDispatch::IntegrationTest
  describe "GET #show" do
    it "loads the todo item details page" do
      get project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one))
      assert_response :success
      assert_select "h1.todo-item-description", todo_items(:one).description
    end

    it "shows todo list breadcrumgs" do
      get project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one))
      assert_select "a.todo-item-breadcrumb-link", todo_lists(:one).name
    end
  end

  describe "GET #new" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get new_project_todo_list_todo_item_path(projects(:everest), todo_lists(:one))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the new todo item page" do
        get new_project_todo_list_todo_item_path(projects(:everest), todo_lists(:one))
        assert_response :success
        assert_select "h2.title", "New To-do Item"
      end
    end
  end

  describe "GET #edit" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get edit_project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the edit todo item page" do
        get edit_project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one))
        assert_response :success
        assert_select "h2.title", "Edit To-do Item"
        assert_select "input" do
          assert_select "[value=?]", todo_items(:one).description
        end
      end
    end
  end

  describe "POST #create" do
    describe "when no user is logged in" do
      it "does not create a new todo item" do
        assert_no_difference "TodoItem.count" do
          post project_todo_list_todo_items_path(projects(:everest), todo_lists(:one)), params: { todo_item: { description: "My new todo item", assigned_to_id: users(:project_admin).id } }
        end
      end

      it "redirects to the login page page" do
        post project_todo_list_todo_items_path(projects(:everest), todo_lists(:one)), params: { todo_item: { description: "My new todo item", assigned_to_id: users(:project_admin).id } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "creates a new todo item" do
        assert_difference "TodoItem.count", 1 do
          post project_todo_list_todo_items_path(projects(:everest), todo_lists(:one)), params: { todo_item: { description: "My new todo item", assigned_to_id: users(:project_admin).id } }
        end
        assert_equal "My new todo item", TodoItem.last.description
      end

      it "redirects to the project todo list page" do
        post project_todo_list_todo_items_path(projects(:everest), todo_lists(:one)), params: { todo_item: { description: "My new todo item", assigned_to_id: users(:project_admin).id } }
        assert_redirected_to project_todo_list_path(projects(:everest), todo_lists(:one))
      end
    end
  end

  describe "PATCH #update" do
    describe "when no user is logged in" do
      it "does not update the todo item record" do
        assert_no_changes -> { TodoItem.find(todo_items(:one).id).description } do
          patch project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one)), params: { todo_item: { description: "Change the description" } }
        end
      end

      it "redirects to the login page page" do
        patch project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one)), params: { todo_item: { description: "Change the description" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "updates the todo item record" do
        assert_changes -> { TodoItem.find(todo_items(:one).id).description } do
          patch project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one)), params: { todo_item: { description: "Change the description" } }
        end
        assert_equal "Change the description", TodoItem.find(todo_items(:one).id).description
      end

      describe "when responding to html form update request" do
        it "redirects to the project todo list page" do
          patch project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one)), params: { todo_item: { description: "Change the description" } }
          assert_redirected_to project_todo_list_path(projects(:everest), todo_lists(:one))
        end
      end

      describe "when js request to mark todo item completed" do
        it "returns js to update page content" do
          patch project_todo_list_todo_item_path(projects(:everest), todo_lists(:one), todo_items(:one), format: :js), params: { todo_item: { is_complete: 1 } }
          assert_match /var newChartData = {\"complete\":1,\"incomplete\":1};/, response.body
        end
      end
    end
  end

  private

  def login_as(user)
    post login_path, params: { email: user.email, password: "secret" }
  end
end
