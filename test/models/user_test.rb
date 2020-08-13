require 'test_helper'

# bundle exec ruby -Itest test/models/user_test.rb
class UserTest < ActiveSupport::TestCase
  describe "#is_admin_on?" do
    it "returns true when target has admin role on project" do
      assert users(:project_admin).is_admin_on?(projects(:everest))
    end

    it "returns false when target has user role on project" do
      user_projects(:project_admin).update(role: "user")
      refute users(:project_admin).is_admin_on?(projects(:everest))
    end

    it "returns false when no user_project record exists" do
      refute users(:project_admin).is_admin_on?(projects(:mlymi))
    end
  end

  describe "#initials" do
    it "produces expected string from two word name" do
      assert_equal "CF", users(:project_admin).initials
    end

    it "produces expected string from one word name" do
      users(:project_admin).update(name: "Carl")
      assert_equal "C", users(:project_admin).initials
    end

    it "produces expected string from three word name" do
      users(:project_admin).update(name: "Carl The Fox")
      assert_equal "CTF", users(:project_admin).initials
    end
  end
end
