require 'test_helper'

# bundle exec ruby -Itest test/controllers/projects_controller_test.rb
class ProjectsControllerTest < ActionDispatch::IntegrationTest
  describe "GET #index" do
    it "loads the all-projects page" do
      get projects_path
      assert_response :success
      assert_select "h1.projects-page-title", "Josh Jones's Projects"
    end
  end

  describe "GET #show" do
    it "loads the project details page" do
      get project_path(projects(:everest))
      assert_response :success
      assert_select "h1.project-name", projects(:everest).name
    end

    it "shows project document previews" do
      get project_path(projects(:everest))
      assert_select "div.document-preview", count: 2
    end

    it "shows project todo list previews" do
      get project_path(projects(:everest))
      assert_select "div.todo-list-preview", count: 2
    end

    it "only shows un-completed todo list items" do
      get project_path(projects(:everest))
      assert_select "div.todo-item-preview", count: 3

      todo_items(:two).update!(is_complete: true)
      get project_path(projects(:everest))
      assert_select "div.todo-item-preview", count: 2
    end
  end

  describe "GET #new" do
    describe "when no user is logged in" do
      it "redirects to the login page" do
        get new_project_path
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the new project documents page" do
        get new_project_path
        assert_response :success
        assert_select "h2.title", "New project"
      end
    end
  end

  describe "GET #edit" do
    describe "when no user is logged in" do
      it "redirects to the login page" do
        get edit_project_path(projects(:everest))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the edit project page" do
        get edit_project_path(projects(:everest))
        assert_response :success
        assert_select "h2.title", "Edit project"
        assert_select "input" do
          assert_select "[value=?]", projects(:everest).name
        end
      end
    end
  end

  describe "POST #create" do
    describe "when no user is logged in" do
      it "does not create a new project" do
        assert_no_difference "Project.count" do
          post projects_path, params: { project: { name: "Everest II: This time it's personal" } }
        end
      end

      it "redirects to the login page" do
        post projects_path, params: { project: { name: "Everest II: This time it's personal" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "creates a new project" do
        assert_difference "Project.count", 1 do
          post projects_path, params: { project: { name: "Everest II: This time it's personal" } }
        end
        assert_equal "Everest II: This time it's personal", Project.last.name
      end

      it "redirects to the project page" do
        post projects_path, params: { project: { name: "Everest II: This time it's personal" } }
        assert_redirected_to project_path(Project.last)
      end
    end
  end

  describe "PATCH #update" do
    describe "when no user is logged in" do
      it "does not update the project document record" do
        assert_no_changes -> { Project.find(projects(:everest).id).name } do
          patch project_path(projects(:everest)), params: { project: { name: "Everest II: This time it's personal" } }
        end
      end

      it "redirects to the login page" do
        patch project_path(projects(:everest)), params: { project: { name: "Everest II: This time it's personal" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "updates the project record" do
        assert_changes -> { Project.find(projects(:everest).id).name } do
          patch project_path(projects(:everest)), params: { project: { name: "Everest II: This time it's personal" } }
        end
        assert_equal "Everest II: This time it's personal", Project.find(projects(:everest).id).name
      end

      it "redirects to the project page" do
        patch project_path(projects(:everest)), params: { project: { name: "Everest II: This time it's personal" } }
        assert_redirected_to project_path(projects(:everest))
      end
    end
  end

  private

  def login_as(user)
    post login_path, params: { email: user.email, password: "secret" }
  end
end
