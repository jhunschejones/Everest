require 'test_helper'

# bundle exec ruby -Itest test/models/user_project_test.rb
class UserProjectTest < ActiveSupport::TestCase
  test "sets default role as user" do
    user_project = UserProject.create!(user: users(:project_admin), project: projects(:mlymi))
    assert_equal "user", user_project.role
  end

  describe "validations" do
    test "requires valid role" do
      expected_error_message = {:role=>["not included in '[\"admin\", \"user\"]'"]}
      user_project = UserProject.new(user: users(:project_admin), project: projects(:mlymi), role: "robot_leader")
      user_project.validate
      assert_equal expected_error_message, user_project.errors.messages
    end

    test "prevents invalid role" do
      assert_raises ActiveRecord::RecordInvalid do
        UserProject.create!(user: users(:project_admin), project: projects(:mlymi), role: "robot_leader")
      end
    end
  end
end
