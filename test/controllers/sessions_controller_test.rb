require 'test_helper'

# bundle exec ruby -Itest test/controllers/sessions_controller_test.rb
class SessionsControllerTest < ActionDispatch::IntegrationTest
  it "logs existing user in" do
    https!
    get login_path
    assert_response :success

    post login_path, params: { email: users(:project_admin).email, password: "secret_secret" }
    follow_redirect!
    assert_equal projects_path, path
  end

  it "logs user out" do
    login_as(users(:project_admin))
    delete logout_path
    follow_redirect!
    assert_equal "Succesfully logged out", flash[:notice]
    assert_equal login_path, path
  end
end
