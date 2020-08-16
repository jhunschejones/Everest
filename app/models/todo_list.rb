class TodoList < ApplicationRecord
  belongs_to :project
  has_many :todo_items

  scope :ordered, -> { order({ created_at: :desc }) }

  def completion_chart_data
    return nil if todo_items.empty?
    grouped_todo_items = todo_items.group_by(&:is_complete)
    {
      complete: grouped_todo_items[true]&.size || 0,
      incomplete: grouped_todo_items[false]&.size || 0
    }
  end
end
