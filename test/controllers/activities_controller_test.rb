require 'test_helper'

# bundle exec ruby -Itest test/controllers/activities_controller_test.rb
class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  describe "GET #index" do
    it "loads the all-activities page" do
      get activities_path
      assert_response :success
      assert_select "h1.activities-title", "Latest Activity"
    end
  end

  describe "GET #new" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get new_project_activity_path(projects(:everest))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "loads the new project activity page" do
        get new_project_activity_path(projects(:everest))
        assert_response :success
        assert_select "h2.title", "New activity"
      end
    end
  end

  describe "GET #edit" do
    describe "when no user is logged in" do
      it "redirects to the login page page" do
        get edit_project_activity_path(projects(:everest), activities(:getting_started))
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "loads the project activity edit page" do
        get edit_project_activity_path(projects(:everest), activities(:getting_started))
        assert_response :success
        assert_select "h2.title", "Edit activity"
        assert_select "input" do
          assert_select "[value=?]", activities(:getting_started).title
        end
      end
    end
  end

  describe "POST #create" do
    describe "when no user is logged in" do
      it "does not create a new project activity" do
        assert_no_difference "Activity.count" do
          post project_activities_path(projects(:everest)), params: { activity: { title: "Add an activity" } }
        end
      end

      it "redirects to the login page page" do
        post project_activities_path(projects(:everest)), params: { activity: { title: "Add an activity" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "creates a new project activity" do
        assert_difference "Activity.count", 1 do
          post project_activities_path(projects(:everest)), params: { activity: { title: "Add an activity" } }
        end
        assert_equal "Add an activity", Activity.last.title
      end

      it "redirects to the project page" do
        post project_activities_path(projects(:everest)), params: { activity: { title: "Add an activity" } }
        assert_redirected_to project_path(projects(:everest))
      end
    end
  end

  describe "PATCH #update" do
    describe "when no user is logged in" do
      it "does not update the project activity record" do
        assert_no_changes -> { Activity.find(activities(:getting_started).id).title } do
          patch project_activity_path(projects(:everest), activities(:getting_started)), params: { activity: { title: "Change the title" } }
        end
      end

      it "redirects to the login page page" do
        patch project_activity_path(projects(:everest), activities(:getting_started)), params: { activity: { title: "Change the title" } }
        assert_redirected_to login_path
      end
    end

    describe "when an admin user is logged in" do
      before do
        login_as(users(:project_admin))
      end

      it "updates the project activity record" do
        assert_changes -> { Activity.find(activities(:getting_started).id).title } do
          patch project_activity_path(projects(:everest), activities(:getting_started)), params: { activity: { title: "Change the title" } }
        end
        assert_equal "Change the title", Activity.find(activities(:getting_started).id).title
      end

      it "redirects to the project page" do
        patch project_activity_path(projects(:everest), activities(:getting_started)), params: { activity: { title: "Change the title" } }
        assert_redirected_to project_path(projects(:everest))
      end
    end
  end

  private

  def login_as(user)
    post login_path, params: { email: user.email, password: "secret" }
  end
end
