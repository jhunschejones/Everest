class TodoItem < ApplicationRecord
  belongs_to :todo_list
  belongs_to :assigned_to, class_name: "User"
end
