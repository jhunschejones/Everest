require 'test_helper'

# bundle exec ruby -Itest test/models/todo_list_test.rb
class TodoListTest < ActiveSupport::TestCase
  describe "#completion_chart_data" do
    describe "when a todo list has no todo items" do
      before do
        todo_lists(:one).todo_items.destroy_all
      end

      it "retruns nil" do
        assert_nil todo_lists(:one).completion_chart_data, "should return nil when there are no todo items"
      end
    end

    describe "when a todo list has todo items" do
      it "returns expected hash for no completed items" do
        expected_hash = { complete: 0, incomplete: 2 }
        assert_equal expected_hash, todo_lists(:one).completion_chart_data
      end

      it "returns expected hash for some completed items" do
        todo_items(:one).update(is_complete: true)
        expected_hash = { complete: 1, incomplete: 1 }
        assert_equal expected_hash, todo_lists(:one).completion_chart_data
      end

      it "returns expected hash for all completed items" do
        todo_items(:one).update(is_complete: true)
        todo_items(:two).update(is_complete: true)
        expected_hash = { complete: 2, incomplete: 0 }
        assert_equal expected_hash, todo_lists(:one).completion_chart_data
      end
    end
  end
end
