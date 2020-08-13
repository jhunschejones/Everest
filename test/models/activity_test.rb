require 'test_helper'

# bundle exec ruby -Itest test/models/activity_test.rb
class ActivityTest < ActiveSupport::TestCase
  describe "#month_and_year" do
    it "returns month and year in expected string format" do
      expected_format = "#{Date::MONTHNAMES[Time.now.month]} #{Time.now.year}"
      assert_equal expected_format, activities(:getting_started).month_and_year
    end
  end
end
