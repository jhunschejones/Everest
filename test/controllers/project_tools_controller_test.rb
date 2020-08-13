require 'test_helper'

# bundle exec ruby -Itest test/controllers/project_tools_controller_test.rb
class ProjectToolsControllerTest < ActionDispatch::IntegrationTest
  describe "GET new" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get new_project_project_tool_path(projects(:everest))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the new project tools page" do
        get new_project_project_tool_path(projects(:everest))
        assert_response :success
        assert_select "h2.title", "New project tool"
      end
    end
  end

  describe "GET edit" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get edit_project_project_tool_path(projects(:everest), project_tools(:the_code))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "shows the edit project tools page" do
        get edit_project_project_tool_path(projects(:everest), project_tools(:the_code))
        assert_response :success
        assert_select "h2.title", "Edit project tool"
        assert_select "input" do
          assert_select "[value=?]", project_tools(:the_code).name
        end
      end
    end
  end

  describe "POST create" do
    describe "when no user is logged in" do
      it "does not create a new project tool" do
        assert_no_difference "Document.count" do
          post project_project_tools_path(projects(:everest)), params: { project_tool: { name: "My new project tool", link: "everest.joshuahunschejones.com" } }
        end
      end

      it "redirects to the login page page" do
        post project_project_tools_path(projects(:everest)), params: { project_tool: { name: "My new project tool", link: "everest.joshuahunschejones.com" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "creates a new project tool" do
        assert_difference "ProjectTool.count", 1 do
          post project_project_tools_path(projects(:everest)), params: { project_tool: { name: "My new project tool", link: "everest.joshuahunschejones.com" } }
        end
        assert_equal "My new project tool", ProjectTool.last.name
      end

      it "redirects to the project page and shows new project tool" do
        post project_project_tools_path(projects(:everest)), params: { project_tool: { name: "My new project tool", link: "everest.joshuahunschejones.com" } }
        assert_redirected_to project_path(projects(:everest))
        follow_redirect!
        assert_select "h3.project-tool-card-header", "My new project tool"
      end
    end
  end

  describe "PATCH update" do
    describe "when no user is logged in" do
      it "does not update the project tool record" do
        assert_no_changes -> { ProjectTool.find(project_tools(:the_code).id).name } do
          patch project_project_tool_path(projects(:everest), project_tools(:the_code)), params: { project_tool: { name: "The NEW code" } }
        end
      end

      it "redirects to the login page page" do
        patch project_project_tool_path(projects(:everest), project_tools(:the_code)), params: { project_tool: { name: "The NEW code" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "updates the project tool record" do
        assert_changes -> { ProjectTool.find(project_tools(:the_code).id).name } do
          patch project_project_tool_path(projects(:everest), project_tools(:the_code)), params: { project_tool: { name: "The NEW code" } }
        end
        assert_equal "The NEW code", ProjectTool.find(project_tools(:the_code).id).name
      end

      it "redirects to the project page with updated project tool" do
        patch project_project_tool_path(projects(:everest), project_tools(:the_code)), params: { project_tool: { name: "The NEW code" } }
        assert_redirected_to project_path(projects(:everest))
        follow_redirect!
        assert_select "h3.project-tool-card-header", "The NEW code"
      end
    end
  end

  private

  def login_as(user)
    post login_path, params: { email: user.email, password: "secret" }
  end
end
