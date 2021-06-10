require 'test_helper'

# bundle exec ruby -Itest test/models/user_test.rb
class UserTest < ActiveSupport::TestCase
  describe "validations" do
    describe "avatar_color" do
      it "allows valid avatar colors" do
        users(:project_admin).update!(avatar_color: "lime")
        assert_equal "lime", users(:project_admin).avatar_color
      end

      it "prevents invalid avatar colors" do
        assert_raises ActiveRecord::RecordInvalid do
          users(:project_admin).update!(avatar_color: "space_cats")
        end
      end
    end
  end

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
    it "produces expected string from one word name" do
      users(:project_admin).update(name: "Carl")
      assert_equal "C", users(:project_admin).initials
    end

    it "produces expected string from two word name" do
      assert_equal "CF", users(:project_admin).initials
    end

    it "produces expected string from three word name" do
      users(:project_admin).update(name: "Carl The Fox")
      assert_equal "CTF", users(:project_admin).initials
    end
  end

  describe "#firstname_last_initial" do
    it "produces expected string from one word name" do
      users(:project_admin).update(name: "Carl")
      assert_equal "Carl", users(:project_admin).firstname_last_initial
    end

    it "produces expected string from two word name" do
      assert_equal "Carl F.", users(:project_admin).firstname_last_initial
    end

    it "produces expected string from three word name" do
      users(:project_admin).update(name: "Carl The Fox")
      assert_equal "Carl F.", users(:project_admin).firstname_last_initial
    end
  end

  describe "#avatar_color" do
    it "returns the avatar color for the user" do
      users(:project_admin).update!(avatar_color: "lime")
      assert_equal "lime", users(:project_admin).avatar_color
    end

    it "returns magenta as the default color" do
      assert_equal "magenta", users(:project_admin).avatar_color
    end
  end
end
